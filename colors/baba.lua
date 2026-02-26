vim.cmd.colorscheme("default")
vim.g.colors_name = 'baba'

local colors = {
	main_background = "#000000",
}

-- (see :source $VIMRUNTIME/syntax/hitest.vim)
local highlights = {
	-- Text
	Normal = { bg = colors.main_background },

	-- Cursor
	SignColumn = { bg = colors.main_background },

	-- Tabline
	TablineSel = { fg = "#303030", bg = "#c6c6c6" },

	-- Float
	NormalFloat = { bg = colors.main_background },
	FloatBorder = { bg = colors.main_background },

	-- Menu
	Pmenu = { bg = colors.main_background },
}

for group, opts in pairs(highlights) do
	vim.api.nvim_set_hl(0, group, opts)
end
