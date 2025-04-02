require "pluginmanager".ensure("nvim-treesitter", "nvim-treesitter", {}, function()
	require 'nvim-treesitter.configs'.setup {
		highlight = {
			enable = true
		},
		indent = {
			enable = true
		},
	}
end)
