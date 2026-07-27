local go_tab = require "tab".go_tab

local compile_cmd = nil
local compile_buf = nil

local function compile(reset)
	if reset or not compile_cmd then
		compile_cmd = vim.fn.input("Compile command: ")
		if compile_cmd == "" then compile_cmd = nil; return end
	end

	go_tab("compile")

	local old = compile_buf

	vim.cmd("enew")
	compile_buf = vim.api.nvim_get_current_buf()
	pcall(vim.api.nvim_buf_set_name, compile_buf, "compile")

	if old and vim.api.nvim_buf_is_valid(old) then
		vim.api.nvim_buf_delete(old, { force = true })
	end

	vim.fn.jobstart(compile_cmd, {
		term = true,
		on_exit = function()
			if vim.api.nvim_buf_is_valid(compile_buf) then
				vim.fn.setqflist({}, 'r', { title = compile_cmd, lines = vim.api.nvim_buf_get_lines(compile_buf, 0, -1, false) })
			end
		end
	})

	vim.cmd("normal! G")
	vim.keymap.set("t", "<esc>", "<c-\\><c-n>", { buffer = compile_buf })
	vim.cmd("startinsert")
end

vim.keymap.set("n", keymap.CompileReset, function() compile(true) end,  { desc = "Reset compiler" })
vim.keymap.set("n", keymap.Compile, function() compile(false) end, { desc = "Select and compile" })
