vim.api.nvim_create_user_command("Open", function(opts) vim.system({ "xdg-open", opts.args }, { stdout = false, detach = true }) end, -- Open with default app
	{ nargs = 1, complete = "file_in_path", desc = "Open file using xdg-open" })

vim.keymap.set("n", keymap.Terminal, function() vim.system({ "st" }, { stdout = false, detach = true }) end,
	{ desc = "Open new terminal in same directory.", silent = true })

vim.keymap.set("n", keymap.Lazygit,
	function() vim.system({ "st", "-e", "lazygit" }, { stdout = false, detach = true }) end,
	{ desc = "Open new terminal in same directory.", silent = true })
