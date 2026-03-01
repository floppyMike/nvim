if vim.g.colors_name then
	vim.cmd("hi clear")
end

vim.g.colors_name = "ice"

local c = {
	white = '#FFFFFF',
	black = '#000000',

	lsp_inlay_hint = '#969696',

	accent = '#59C2FF',
	bg = '#000000',
	fg = '#dddddd',

	tag = '#dddddd',
	func = '#65d1ff', -- functions
	entity = '#59C2FF', -- Types
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
	gutter_active = '#626975',
	selection_inactive = '#122132',
	selection_border = '#304357',
	guide_active = '#3C414A',
	guide_normal = '#1E222A',

	vcs_added = '#7FD962',
	vcs_modified = '#73B8FF',
	vcs_removed = '#F26D78',

	error = '#D95757',
	warning = '#FF8F40',

	vcs_added_bg = '#1D2214',
	vcs_removed_bg = '#2D2220',

	fg_idle = '#565B66',
}

require "highlightgroups".set_hl(c)
