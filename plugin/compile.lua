local go_tab = require "tab".go_tab

local compile_cmd = nil
local compile_buf = nil

local function compile(reset)
	if reset or not compile_cmd then
		compile_cmd = vim.fn.input("Compile command: ")
		if compile_cmd == "" then compile_cmd = nil; return end
	end

	go_tab("compile")

	if compile_buf and vim.api.nvim_buf_is_valid(compile_buf) then
		vim.api.nvim_buf_delete(compile_buf, { force = true })
	end

	vim.cmd("enew")
	compile_buf = vim.api.nvim_get_current_buf()
	pcall(vim.api.nvim_buf_set_name, compile_buf, "compile")

	vim.fn.termopen(compile_cmd, {
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

vim.keymap.set("n", "<F6>", function() compile(true) end,  { desc = "Reset compiler" })
vim.keymap.set("n", "<F7>", function() compile(false) end, { desc = "Select and compile" })
