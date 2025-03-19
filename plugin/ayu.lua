require "pluginmanager".ensure("Shatur", "neovim-ayu", {})

require 'ayu'.setup {
	overrides = {
		LineNrAbove = { fg = '#51B3EC' },
		LineNrBelow = { fg = '#FB508F' },
	},
}

vim.cmd [[colorscheme ayu]]
