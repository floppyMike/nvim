local compile_cmd = nil
local compile_win = nil
local compile_buf = nil

local function compile()
	if not compile_cmd then
		compile_cmd = vim.fn.input("Compile command: ")
		if compile_cmd == "" then compile_cmd = nil; return end
	end

	local win = vim.api.nvim_get_current_win()

	if compile_win and vim.api.nvim_win_is_valid(compile_win) then
		vim.api.nvim_set_current_win(compile_win)
	else
		vim.cmd("botright 8new")
		compile_win = vim.api.nvim_get_current_win()
		vim.wo[compile_win].winfixheight = true
	end

	local prev_buf = compile_buf
	vim.cmd("enew")
	compile_buf = vim.api.nvim_get_current_buf()
	vim.fn.termopen(compile_cmd, {
		on_exit = function()
			if vim.api.nvim_buf_is_valid(compile_buf) then
				vim.fn.setqflist({}, 'r', { title = compile_cmd, lines = vim.api.nvim_buf_get_lines(compile_buf, 0, -1, false) })
			end
		end
	})

	vim.cmd("normal! G")

	if prev_buf and vim.api.nvim_buf_is_valid(prev_buf) then
		vim.api.nvim_buf_delete(prev_buf, { force = true })
	end

	vim.api.nvim_set_current_win(win)
end

local function compile_reset()
	compile_cmd = nil
	compile()
end

local function compile_close()
	if compile_win and vim.api.nvim_win_is_valid(compile_win) then
		vim.api.nvim_win_close(compile_win, true)
	end

	if compile_buf and vim.api.nvim_buf_is_valid(compile_buf) then
		vim.api.nvim_buf_delete(compile_buf, { force = true })
	end

	compile_win = nil
	compile_buf = nil
end

vim.keymap.set("n", "<F6>",         compile_close, { desc = "Close compiler" })
vim.keymap.set("n", "<F7>",         compile,       { desc = "Select and compile" })
vim.keymap.set("n", "<leader><F7>", compile_reset, { desc = "Reset compiler" })
