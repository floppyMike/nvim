require "pluginmanager".ensure("nvim-treesitter", "nvim-treesitter", {})

require 'nvim-treesitter.configs'.setup {
	highlight = {
		enable = true
	},
	indent = {
		enable = true
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = false,
			scope_incremental = false,
			node_incremental = "<tab>",
			node_decremental = "<s-tab>",
		},
	},
}
