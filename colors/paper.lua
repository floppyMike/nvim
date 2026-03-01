if vim.g.colors_name then
	vim.cmd("hi clear")
end

vim.g.colors_name = "paper"
vim.o.background = "light"

local c = {
	white = '#FFFFFF',
	black = '#000000',

	lsp_inlay_hint = '#969696',

	accent = '#045993',
	bg = '#dddddd',
	fg = '#222222',

	cursor = '#777777',

	tag = '#222222',
	func = '#db6000', -- functions
	entity = '#045993', -- Types
	string = '#75499c',
	regexp = '#75499c',
	markup = '#d1e3ff',
	keyword = '#000000',
	special = '#222222',
	comment = '#636A72',
	constant = '#118011',
	operator = '#000000',
	lsp_parameter = '#222222',

	line = '#cccccc',
	panel_bg = '#000000',
	panel_shadow = '#111111',
	panel_border = '#aaaaaa',
	gutter_normal = '#454B55',
	selection_inactive = '#bbbbbb',
	guide_normal = '#999999',

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
