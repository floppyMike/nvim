local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local command = vim.api.nvim_create_user_command

command('Bd', 'bp | sp | bn | bd!', {})

autocmd('TermClose', {
	desc = "Close terminal on exit without message.",
	command = 'Bd ' .. vim.fn.expand('<abuf>')
})

autocmd('TermOpen',	{
	desc = "If terminal focused immediately start typing.",
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


-- Better netrw

local netrw_id = vim.api.nvim_create_augroup("netrw_map", { clear = true })

autocmd("FileType", {
	desc = "Netrw controls",
	pattern = "netrw",
	group = netrw_id,
	command = "nmap <buffer> h -^ | nmap <buffer> l <cr> | nmap <buffer> . gh | nmap <buffer> L <cr>:Lexplore<cr>"
})
