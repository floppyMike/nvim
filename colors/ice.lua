if vim.g.colors_name then
	vim.cmd("hi clear")
end

vim.g.colors_name = "ice"
vim.o.background = "dark"

local c = {
	white = '#FFFFFF',
	black = '#000000',

	lsp_inlay_hint = '#969696',

	accent = '#2ab1ff',
	bg = '#000000',
	fg = '#dddddd',

	cursor = '#cccccc',

	tag = '#dddddd',
	func = '#65d1ff', -- functions
	entity = '#2ab1ff', -- Types
	string = '#c6efff',
	regexp = '#95E6CB',
	markup = '#d1e3ff',
	keyword = '#eeffff',
	special = '#ffffff',
	comment = '#636A72',
	constant = '#0475a4',
	operator = '#eeffff',
	lsp_parameter = '#dddddd',

	line = '#222222',
	panel_bg = '#0F131A',
	panel_shadow = '#05070A',
	panel_border = '#000000',
	gutter_normal = '#454B55',
	selection_inactive = '#122132',
	guide_normal = '#555555',

	vcs_added = '#7FD962',
	vcs_modified = '#73B8FF',
	vcs_removed = '#F26D78',

	vcs_added_bg = '#1D2214',
	vcs_removed_bg = '#2D2220',

	error = '#D95757',
	warning = '#FF8F40',

	fg_idle = '#565B66',
}

require "highlightgroups".set_hl(c)
