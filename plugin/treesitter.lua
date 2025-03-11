require"pluginmanager".ensure("nvim-treesitter", "nvim-treesitter", {})

require'nvim-treesitter.configs'.setup {
	highlight = {
		enable = true
	},
	indent = {
		enable = true
	}
}
