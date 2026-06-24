require "mini.files".setup()

vim.keymap.set("n", keymap.Filesytem, MiniFiles.open, { desc = "Open filesystem" })

vim.keymap.set("n", keymap.FilesytemLocal, function()
	MiniFiles.open(vim.api.nvim_buf_get_name(0), true)
	MiniFiles.reveal_cwd()
end, { desc = "Open filesystem local to file" })
