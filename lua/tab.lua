local M = {}

function M.go_tab(role, cmd, esc)
	local target
	for _, t in ipairs(vim.api.nvim_list_tabpages()) do
		local ok, val = pcall(vim.api.nvim_tabpage_get_var, t, "role")
		if ok and val == role then target = t break end
	end

	target = target or (role == "code" and vim.api.nvim_list_tabpages()[1])

	if target then
		vim.api.nvim_set_current_tabpage(target)
		vim.t.role = role
	else
		vim.cmd("$tabnew")
		vim.t.role = role

		if cmd then
			vim.cmd(cmd == "term" and "terminal" or "terminal " .. cmd)
			local buf = vim.api.nvim_get_current_buf()

			pcall(vim.api.nvim_buf_set_name, buf, role)

			vim.api.nvim_create_autocmd("TermClose", {
				buffer = buf,
				callback = function() vim.schedule(function() pcall(vim.api.nvim_buf_delete, buf, { force=true }) end) end
			})

			if esc then vim.keymap.set("t", "<Esc>", "<c-\\><c-n>", { buffer = buf }) end
		end
	end

	vim.cmd(vim.bo.buftype == "terminal" and "startinsert" or "stopinsert")
end

return M
