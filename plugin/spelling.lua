vim.keymap.set("n", keymap.SpellSuggest, MiniExtra.pickers.spellsuggest, { desc = "Spelling suggestions" })

vim.keymap.set("n", keymap.SpellToggle, function()
	vim.opt_local.spell = not (vim.opt_local.spell:get())
	print("spell: " .. tostring(vim.opt_local.spell:get()))
end, { desc = "Enable spell checking" })

vim.keymap.set("n", keymap.SpellSwitchEn, function()
	vim.opt.spelllang = { 'en' }
	print("lang: english")
end, { desc = "Set spellcheck to english" })

vim.keymap.set("n", keymap.SpellSwitchDe, function()
	vim.opt.spelllang = { 'de' }
	print("lang: german")
end, { desc = "Set spellcheck to german" })
