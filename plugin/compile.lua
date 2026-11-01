local compile_cmd = nil
local compile_buf = nil

local function compile(reset)
	if reset or not compile_cmd then
		compile_cmd = vim.fn.input("Compile command: ")
		if compile_cmd == "" then compile_cmd = nil; return end
	end

	local buf = vim.api.nvim_create_buf(true, false)
	vim.b[buf].role = "compile"

	if compile_buf and vim.api.nvim_buf_is_valid(compile_buf) then
		for _, win in ipairs(vim.fn.win_findbuf(compile_buf)) do vim.api.nvim_win_set_buf(win, buf) end -- Keep it visible
		vim.api.nvim_buf_delete(compile_buf, { force = true })
	end

	compile_buf = buf

	vim.api.nvim_buf_call(buf, function()
		vim.fn.jobstart(compile_cmd, {
			term = true,
			on_exit = function(_, code)
				if not vim.api.nvim_buf_is_valid(buf) then return end -- Replaced by a newer run

				vim.fn.setqflist({}, 'r', { title = compile_cmd, lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false) })
				vim.notify("Compile exited with " .. code, code == 0 and vim.log.levels.INFO or vim.log.levels.ERROR)
			end
		})
		pcall(vim.cmd, "keepalt file compile")
	end)

	vim.keymap.set("t", "<esc>", "<c-\\><c-n>", { buffer = buf })
	if vim.api.nvim_get_current_buf() == buf then vim.cmd("startinsert") end
end

vim.keymap.set("n", keymap.CompileReset, function() compile(true) end,  { desc = "Reset compiler" })
vim.keymap.set("n", keymap.Compile, function() compile(false) end, { desc = "Select and compile" })
