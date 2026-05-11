require "mini.completion".setup {
	mappings = {
		force_twostep = keymap.CompleteFirst,
		force_fallback = keymap.CompleteSecond,
		scroll_down = keymap.ComplateUp,
		scroll_up = keymap.ComplateDown,
	}
}

vim.api.nvim_create_autocmd("CompleteDone", {
	callback = function()
		if vim.v.event.complete_type == 'files' and vim.v.event.reason == 'accept' then
			vim.api.nvim_feedkeys("\24\6", "m", false)
		end
	end
})
