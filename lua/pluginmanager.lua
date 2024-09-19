-------------------------------------
-- Git helpers
-------------------------------------

--- Convert author name plugin name to github url
local function to_git_url(author, plugin)
	return string.format('https://github.com/%s/%s.git', author, plugin)
end

--- Pull a existing git project in opt
-- @param name Name of the git project
-- @param path Path of project
-- @param on_success Function with name of project input
local function git_pull(name, path, on_success)
	local branch = vim.fn.system("git -C " .. path .. " branch --show-current | tr -d '\n'")

	vim.loop.spawn('git', {
		-- pull from origin at branch with only one commit (shallow) and update only if not changes
		-- made. Print progress. Merge into current branch
		args = { 'pull', 'origin', branch, '--update-shallow', '--ff-only', '--progress', '--rebase=false' },
		cwd = path,
	}, vim.schedule_wrap(function(code)
		if code == 0 then
			on_success(name)
		else
			vim.api.nvim_err_writeln(name .. ' pulled unsuccessfully')
		end
	end))
end

--- Clone a project into opt
-- @param name Name of the git project
-- @param path Path where the project will be cloned
-- @param git_url HTTP URL to the project
-- @param on_success Function with name of project input
local function git_clone(name, path, git_url, on_success)
	vim.loop.spawn('git', {
		-- Clone only 1 commit deep
		args = { 'clone', '--depth=1', git_url },
		cwd = path,
	}, vim.schedule_wrap(function(code)
		if code == 0 then
			on_success(name)
		else
			vim.api.nvim_err_writeln(name .. ' cloned unsuccessfully')
		end
	end))
end

--- Run a command in a path
-- @param cmd Command to run
-- @param args Arguments list for command (argv like)
-- @param path Path to run command on
-- @param on_success Function which runs on success
local function run_cmd(cmd, path, on_success)
	vim.loop.spawn(cmd.cmd, {
		args = cmd.args,
		cwd = path,
	}, vim.schedule_wrap(function(code)
		if code == 0 then
			on_success()
		else
			vim.api.nvim_err_writeln('Unsuccessfully ran command ' .. cmd.cmd .. ' in ' .. path)
		end
	end))
end

-------------------------------------
-- Plugin Directiory Management
-------------------------------------

-- Where plugins will be installed
local opt = vim.fn.stdpath('data') .. '/site/pack/plugin_manager/opt'
-- Plugin Configuration
local manifest = vim.fn.stdpath('config') .. '/plugin_manifest.lua'

local M = {}

--- Load plugins from opt created in manifest
function M.setup()
	vim.fn.mkdir(opt, 'p')

	-- Manifest structure (lua file):
	-- use {
	-- 	{ name = "author/plugin" },
	-- 	post_update = function(dir)
	-- 		<setup plugin>
	-- 	end
	-- }

	M.plugins = {}

	_G.use = function(opts)
		local num_plugs = #opts

		for key, value in pairs(opts) do
			if key ~= "post_update" then
				local _, _, author, plugin = string.find(value.name, '^([^ /]+)/([^ /]+)$')

				M.plugins[plugin] = value

				--- Load the plugin to neovim and call post
				-- @param plugin Plugin name
				-- @param opts Options from the plugin_manifest.lua file
				local load_plugin = function()
					vim.cmd('packadd! ' .. plugin)
					num_plugs = num_plugs - 1

					if num_plugs == 0 and opts.post_update then
						local dir = opt .. '/' .. plugin
						opts.post_update(dir)
					end
				end

				if vim.fn.isdirectory(string.format("%s/%s", opt, plugin)) ~= 0 then
					load_plugin()
				else
					local url = to_git_url(author, plugin)
					git_clone(plugin, opt, url, function(name)
						if (value.cmd ~= nil) then
							run_cmd(value.cmd, opt .. '/' .. plugin, load_plugin)
						else
							load_plugin()
						end
					end)
				end
			end
		end

	end

	if vim.fn.filereadable(manifest) ~= 0 then
		dofile(manifest)
	end

	_G.use = nil

	vim.cmd [[ command! PluginUpdate lua require('pluginmanager').pack_update() ]]
	vim.cmd [[ command! PluginClear lua require('pluginmanager').clear_unused() ]]
end

--- Clear plugins that arent in the manifest
function M.clear_unused()
	for _, dir in ipairs(vim.fn.readdir(opt)) do
		local absolute = opt .. '/' .. dir

		if not M.plugins[dir] then
			vim.fn.delete(absolute, 'rf')
			print("Deleted " .. absolute)
		end
	end
end

--- Pull changes for each plugin
function M.pack_update()
	for plugin, value in pairs(M.plugins) do
		local absolute = opt .. '/' .. plugin
		git_pull(plugin, absolute, function(name)
			if (value.cmd ~= nil) then
				run_cmd(value.cmd, opt .. '/' .. plugin, function() end)
			end
			print("Updated " .. name)
		end)
	end
end

M.setup()
return M
