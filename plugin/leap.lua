require "pluginmanager".ensure("ggandor", "leap.nvim", {}, function()
	vim.keymap.set({'n', 'x', 'o'}, 's',  '<Plug>(leap-forward)')
	vim.keymap.set({'n', 'x', 'o'}, 'S',  '<Plug>(leap-backward)')
end)
