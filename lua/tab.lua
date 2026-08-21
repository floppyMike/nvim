local M = {}

--- Find a tab with assigned role
local function find_tab(role)
	for _, t in ipairs(vim.api.nvim_list_tabpages()) do
		local ok, val = pcall(vim.api.nvim_tabpage_get_var, t, "role")
		if ok and val == role then return t end
	end
end

--- Enter insert mode if terminal
local function enter_insert_if_terminal()
	vim.cmd(vim.bo.buftype == "terminal" and "startinsert" or "stopinsert")
end

--- Run `cmd` in a terminal taking the current tab, closing the tab when it exits
local function spawn(role, cmd)
	vim.cmd("terminal " .. cmd)

	local buf, tab = vim.api.nvim_get_current_buf(), vim.api.nvim_get_current_tabpage()
	pcall(vim.api.nvim_buf_set_name, buf, role)

	vim.api.nvim_create_autocmd("TermClose", {
		buffer = buf,
		callback = function()
			vim.schedule(function()
				if vim.api.nvim_tabpage_is_valid(tab) then
					pcall(vim.cmd, vim.api.nvim_tabpage_get_number(tab) .. "tabclose")
				end

				pcall(vim.api.nvim_buf_delete, buf, { force = true })
			end)
		end
	})
end

--- Tag the current tab with `role`, closing any other tab already holding it
function M.claim_tab(role)
	local cur = vim.api.nvim_get_current_tabpage()
	vim.t.role = role

	for _, t in ipairs(vim.api.nvim_list_tabpages()) do
		local ok, val = pcall(vim.api.nvim_tabpage_get_var, t, "role")
		if t ~= cur and ok and val == role then
			pcall(vim.cmd, vim.api.nvim_tabpage_get_number(t) .. "tabclose")
		end
	end
end

--- Jump to a tab with the role, doing nothing if doesn't exist
function M.jump_tab(role)
	local target = find_tab(role)
	if not target then return vim.notify("No " .. role .. " tab", vim.log.levels.WARN) end

	vim.api.nvim_set_current_tabpage(target)
	enter_insert_if_terminal()
end

--- Jump to a tab with the role, creating it when missing.
function M.go_tab(role, cmd)
	local target = find_tab(role)

	if target then
		vim.api.nvim_set_current_tabpage(target)
	else
		vim.cmd("$tabnew")
		vim.t.role = role
		if cmd then spawn(role, cmd) end
	end

	enter_insert_if_terminal()
end

return M
