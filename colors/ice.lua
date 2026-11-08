if vim.g.colors_name then
	vim.cmd("hi clear")
end

vim.g.colors_name = "ice"
vim.o.background = "dark"

local c = {
	white = '#FFFFFF',              -- Text on the Error badge, nothing else

	lsp_inlay_hint = '#969696',     -- Inlay hints and the pmenu extra column

	accent = '#2ab1ff',             -- Eye-catcher: info, match ranges, float titles
	indicator = '#eeffff',          -- Filled chips: mode, cursor position, tab counter
	bg = '#000000',                 -- Editor background, and text on every filled chip
	fg = '#dddddd',                 -- Default text

	cursor = '#cccccc',             -- The caret block

	tag = '#dddddd',                -- Fields, properties, links
	func = '#65d1ff',               -- Functions and directories
	entity = '#2ab1ff',             -- Types, modules, tag names
	string = '#c6efff',             -- Strings and prompts
	regexp = '#95E6CB',             -- Hints, notes, regex
	markup = '#d1e3ff',             -- Markup, exceptions, TODO
	keyword = '#eeffff',            -- Keywords, statements, titles
	special = '#ffffff',            -- Delimiters and structure
	comment = '#636A72',            -- Comments and dimmed labels
	constant = '#0475a4',           -- Constants and literals
	operator = '#eeffff',           -- Operators
	lsp_parameter = '#dddddd',      -- LSP parameter tokens

	line = '#222222',               -- Cursorline and column band
	panel_bg = '#000000',           -- Statusline, winbar, fold background
	panel_shadow = '#000000',       -- Tabline background
	panel_border = '#000000',       -- Statusline and tabline section background
	gutter_bg = '#0a0a0a',          -- Number and sign column background
	line_nr = '#6d757f',            -- The digits themselves
	gutter_normal = '#454B55',      -- Window separators, tab and space marks
	selection_inactive = '#333333', -- Visual, pmenu, word under cursor
	guide_normal = '#555555',       -- Non-text marks and the pmenu thumb

	vcs_added = '#7FD962',          -- Git added
	vcs_modified = '#73B8FF',       -- Git changed
	vcs_removed = '#F26D78',        -- Git removed, trailing whitespace

	vcs_added_bg = '#1D2214',       -- Diff added line background
	vcs_removed_bg = '#2D2220',     -- Diff removed line background

	ok = '#7FD962',                 -- Success: passing tests, checked items
	error = '#D95757',              -- Errors and breakpoints
	warning = '#FF8F40',            -- Warnings and the current search match

	fg_idle = '#565B66',            -- Inactive windows, unused and deprecated code
}

require "highlightgroups".set_hl(c)
