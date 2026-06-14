local function open_terminal(cmd)
	vim.cmd("tabnew")

	vim.fn.termopen(cmd, {
		on_exit = function(_, code, _)
			if code == 0 then pcall(vim.cmd, "bd") end
		end,
	})

	vim.cmd("startinsert")
end

vim.keymap.set("n", keymap.Terminal, function()
	open_terminal(vim.o.shell)
end, { desc = "Open new terminal in same directory.", silent = true })

vim.keymap.set("n", keymap.Lazygit, function()
	open_terminal({ "lazygit" })
end, { desc = "Open a lazygit instance", silent = true })

vim.keymap.set("t", "<A-Esc>", "<C-\\><C-n>", { desc = "Escape terminal", silent = true })
