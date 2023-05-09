local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Terminal Autoclose on exit. (no weird "Process exit with 0" message)
vim.api.nvim_create_autocmd('TermClose',
	{
		command = 'bdelete! ' .. vim.fn.expand('<abuf>')
	})
vim.api.nvim_create_autocmd('TermOpen',
	{
		command = 'startinsert'
	})

autocmd("TextYankPost", {
	desc = "Highlight yanked text",
	group = augroup("highlightyank", { clear = true }),
	pattern = "*",
	callback = function() vim.highlight.on_yank() end,
})

autocmd("FileType", {
	desc = "Unlist quickfist buffers",
	group = augroup("unlist_quickfist", { clear = true }),
	pattern = "qf",
	callback = function() vim.opt_local.buflisted = false end,
})
