-- Plugin Dir
local opt = vim.fn.stdpath('data') .. '/site/pack/plugin_manager/opt'
-- Plugin Tracker
local manifest = vim.fn.stdpath('config') .. '/plugin_manifest.lua'

local function to_git_url(author, plugin)
	return string.format('https://github.com/%s/%s.git', author, plugin)
end

local function git_pull(name, on_success)
	local dir = opt .. name
	local branch = vim.fn.system("git -C " .. dir .. " branch --show-current | tr -d '\n'")

	-- Async
	vim.loop.spawn('git', {
		-- pull from origin at branch with only one commit (shallow) and update only if not changes
		-- made. Print progress. Merge into current branch
		args = { 'pull', 'origin', branch, '--update-shallow', '--ff-only', '--progress', '--rebase=false' },
		-- Current working directory
		cwd = dir,
		-- Do on finished
	}, vim.schedule_wrap(function(code)
		if code == 0 then
			on_success(name)
		else
			vim.api.nvim_err_writeln(name .. ' pulled unsuccessfully')
		end
	end))
end

local function git_clone(name, git_url, cwd, on_success)
	-- Async
	vim.loop.spawn('git', {
		-- Clone only 1 commit deep
		args = { 'clone', '--depth=1', git_url },
		-- Current working directory
		cwd = cwd,
	}, vim.schedule_wrap(function(code)
		if code == 0 then
			on_success(name)
		else
			vim.api.nvim_err_writeln(name .. ' cloned unsuccessfully')
		end
	end))
end

local load_plugin = function(plugin, opts)
	-- Load the plugin
	vim.cmd('packadd! ' .. plugin)

	-- Run post update
	if opts.post_update then
		local dir = opt .. '/' .. plugin
		opts.post_update(dir)
	end
end

local M = {}

function M.setup()
	vim.fn.mkdir(opt, 'p') -- create opt if not exist

	M.plugins = {}

	-- Define keyword use for manifest
	_G.use = function(opts)
		-- Parse manifest entry
		local _, _, author, plugin = string.find(opts[1], '^([^ /]+)/([^ /]+)$')

		-- Store into table for PackUpdate
		table.insert(M.plugins, {
			plugin = plugin,
		})

		-- Source the plugin
		if vim.fn.isdirectory(opt .. '/' .. plugin) ~= 0 then
			load_plugin(plugin, opts)
		else
			git_clone(plugin, to_git_url(author, plugin), opt, function(name) load_plugin(name, opts) end)
		end
	end

	-- Run manifest
	if vim.fn.filereadable(manifest) ~= 0 then
		dofile(manifest)
	end

	-- Undeclare
	_G.use = nil

	-- Update plugins from remote
	vim.cmd [[ command! PluginUpdate lua require('pluginmanager').pack_update() ]]
end

function M.pack_update()
	-- Temporary directory
	local temp_dir = vim.fn.fnamemodify(vim.fn.tempname(), ":h")

	-- Go through stored list and delete not mentioned plugins
	_G.use = function(opts)
		-- Parse manifest entry
		local _, _, author, plugin = string.find(opts[1], '^([^ /]+)/([^ /]+)$')

		local dir = opt .. '/' .. plugin

		-- Source the plugin
		if vim.fn.isdirectory(dir) ~= 0 then
			local temp_plug = temp_dir .. '/' .. plugin
			vim.loop.fs_rename(dir, temp_plug) -- Move directory
			print("Move " .. dir .. " to " .. temp_plug)
		else
			-- Clone into directory and activate it
			git_clone(plugin, to_git_url(author, plugin), temp_dir, function(name) load_plugin(name, opts) end)
			print("Cloning " .. plugin .. " into " .. temp_dir)
		end
	end

	-- Run manifest
	if vim.fn.filereadable(manifest) ~= 0 then
		dofile(manifest)
	end

	-- Undeclare
	_G.use = nil

	-- Delete remainer
	vim.fn.delete(opt)
	print("Deleting " .. opt)

	-- Move everything back
	vim.loop.fs_rename(temp_dir, opt)
	print("Moving " .. temp_dir .. " to " .. opt)
end

M.setup()
return M
