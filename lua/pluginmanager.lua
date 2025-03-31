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
-- @param on_success Function to run on success
local function git_clone(name, git_url, on_success)
	-- Clone only 1 commit deep into path
	vim.system({ "git", "clone", "--depth=1", git_url, name },
		{ cwd = start, stdout = false, stderr = false }, function(ret)
			if ret.code == 0 then
				on_success()
			else
				vim.schedule(function()
					vim.notify("Error: Failed to clone \"" .. name .. "\"", vim.log.levels.ERROR)
				end)
			end
		end)
end

--- Async pull a existing git project in start
-- @param name Name of the git project
-- @param on_success Function to run on success
local function git_pull(name, on_success)
	-- Shallow pull
	vim.system({ "git", "pull", "--update-shallow", "--ff-only", "--progress", "--rebase=false" },
		{ cwd = to_absolute(name), stdout = false, stderr = false }, function(obj)
			if (obj.code == 0) then
				on_success()
			else
				vim.schedule(function()
					vim.notify("Error: Failed to pull \"" .. name .. "\"", vim.log.levels.ERROR)
				end)
			end
		end)
end

--- Sync run cmd in project in start
-- @param name Name of the git project
-- @param cmd Command to run as a array
-- @param on_success Function to run on success
local function run_cmd(name, cmd, on_success)
	-- Run the command in directory
	vim.system(cmd, { cwd = to_absolute(name), stdout = false, stderr = false }, function(ret)
		if ret.code == 0 then
			on_success()
		else
			vim.schedule(function()
				vim.notify("Error: Failed to run command for \"" .. name .. "\"", vim.log.levels.ERROR)
			end)
		end
	end)
end

-- State
local M = {}

function M.ensure(author, plugin, cmd, config)
	-- Create Directory
	vim.fn.mkdir(start, 'p')

	-- Register plugin
	M.plugins[plugin] = cmd

	-- If plugin doesn't exist => clone and load plugin, Else do nothing
	if vim.fn.isdirectory(to_absolute(plugin)) == 0 then
		git_clone(plugin, to_github_url(author, plugin), function()
			vim.schedule(function()
				vim.notify("Success: Cloned \"" .. plugin .. "\"", vim.log.levels.INFO)
			end)
			if next(cmd) ~= nil then -- If a command was given
				run_cmd(plugin, cmd, function()
					vim.schedule(function()
						vim.notify("Success: Ran command for \"" .. plugin .. "\"", vim.log.levels.INFO)
					end)

					vim.cmd('packadd! ' .. plugin)
					config()
				end)
			else
				vim.cmd('packadd! ' .. plugin)
				config()
			end
		end)
	else
		config()
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
			vim.notify("Success: Deleted \"" .. dir .. "\"", vim.log.levels.INFO)
		end
	end
end

--- Pull changes for each plugin and optionally run cmd
function M.pack_update()
	for plugin, cmd in pairs(M.plugins) do
		git_pull(plugin, function()
			vim.schedule(function()
				vim.notify("Success: Pulled \"" .. plugin .. "\"", vim.log.levels.INFO)
			end)
			if next(cmd) ~= nil then -- If a command was given
				run_cmd(plugin, cmd, function()
					vim.schedule(function()
						vim.notify("Success: Ran command for \"" .. plugin .. "\"", vim.log.levels.INFO)
					end)
				end)
			end
		end)
	end

	vim.schedule(function()
		vim.notify("Warning: Reload neovim for updates to take affect.", vim.log.levels.WARN)
	end)
end

return M
