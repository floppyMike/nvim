-- Where plugins will be installed
local start = vim.fn.stdpath('data') .. '/site/pack/plugin_manager/start'

--- Convert author name plugin name to github url
local function to_github_url(author, plugin)
	return string.format('https://github.com/%s/%s.git', author, plugin)
end

--- Create absolute path in start
local function to_absolute(plugin)
	return string.format('%s/%s', start, plugin)
end

--- Sync clone a project into start
-- @param name Name of the git project
-- @param git_url HTTP URL to the project
local function git_clone(name, git_url)
	-- Clone only 1 commit deep into path
	local ret = vim.system({ "git", "clone", "--depth=1", git_url, name }, { cwd = start, stdout = false, stderr = false }):wait()

	if ret.code ~= 0 then
		return true -- Exit plugin
	end

	return false -- Continue
end

--- Async pull a existing git project in start
-- @param name Name of the git project
-- @param on_success Function to run on success
local function git_pull(name, on_success)
	-- Shallow pull
	local ret = vim.system({ "git", "pull", "--update-shallow", "--ff-only", "--progress", "--rebase=false" }, { cwd = to_absolute(name), stdout = false, stderr = false }, function(obj)
		if (obj.code == 0) then
			on_success()
		end
	end)
end

--- Sync run cmd in project in start
-- @param name Name of the git project
-- @param cmd Command to run as a array
local function run_cmd(name, cmd)
	if next(cmd) ~= nil then -- If a command was given
		-- Run the command in directory
		local ret = vim.system(cmd, { cwd = to_absolute(name), stdout = false, stderr = false }):wait()
		if ret.code ~= 0 then
			return true -- Exit plugin
		end
	end

	return false -- Continue
end

-- State
local M = {}

function M.ensure(author, plugin, cmd)
	-- Create Directory
	vim.fn.mkdir(start, 'p')

	-- Register plugin
	M.plugins[plugin] = cmd

	-- If plugin doesn't exist => clone and load plugin
	if vim.fn.isdirectory(to_absolute(plugin)) == 0 then
		-- Clone plugin
		local url = to_github_url(author, plugin)
		if (git_clone(plugin, url)) then
			return true
		end

		-- Run cmd if avail
		run_cmd(plugin, cmd)

		-- Load plugin
		vim.cmd('packadd! ' .. plugin)
	end
end

--- Register commands to update and clean
function M.setup()
	M.plugins = {} -- Stores loaded plugins

	vim.cmd [[ command! PluginUpdate lua require('pluginmanager').pack_update() ]]
	vim.cmd [[ command! PluginClear lua require('pluginmanager').clear_unused() ]]
end

--- Clear plugins that weren't loaded
function M.clear_unused()
	for _, dir in ipairs(vim.fn.readdir(start)) do
		if not M.plugins[dir] then
			vim.fn.delete(to_absolute(dir), 'rf')
		end
	end
end

--- Pull changes for each plugin and optionally run cmd
function M.pack_update()
	for plugin, cmd in pairs(M.plugins) do
		git_pull(plugin, function()
			run_cmd(plugin, cmd)
		end)
	end

	vim.notify("Reload neovim for updates to take affect.", vim.log.levels.WARN)
end

return M
