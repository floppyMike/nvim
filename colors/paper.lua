if vim.g.colors_name then
	vim.cmd("hi clear")
end

vim.g.colors_name = "paper"
vim.o.background = "light"

local c = {
	white = '#FFFFFF',              -- Text on the Error badge, nothing else

	lsp_inlay_hint = '#7d7769',     -- Inlay hints and the pmenu extra column

	accent = '#1a5b8f',             -- Eye-catcher: info, match ranges, float titles
	indicator = '#3a4a5a',          -- Filled chips: mode, cursor position, tab counter
	bg = '#f2efe8',                 -- Editor background, and text on every filled chip
	fg = '#2c2a26',                 -- Default text

	cursor = '#d9a441',             -- The caret block. st draws the glyph under it in its own
	                                -- hardcoded background (black), so this must stay light.

	tag = '#7a4a3f',                -- Fields, properties, links
	func = '#a85f00',               -- Functions and directories
	entity = '#1a5b8f',             -- Types, modules, tag names
	string = '#6a4a94',             -- Strings and prompts
	regexp = '#0f6f78',             -- Hints, notes, regex
	markup = '#9c4a86',             -- Markup, exceptions, TODO
	keyword = '#8a3a52',            -- Keywords, statements, titles
	special = '#4a4640',            -- Delimiters and structure
	comment = '#77726a',            -- Comments and dimmed labels
	constant = '#2f6b4f',           -- Constants and literals
	operator = '#5a5650',           -- Operators
	lsp_parameter = '#2c2a26',      -- LSP parameter tokens

	line = '#e6e0d1',               -- Cursorline and column band
	panel_bg = '#eae6dd',           -- Statusline, winbar, fold background
	panel_shadow = '#e0dbd0',       -- Tabline background
	panel_border = '#e6e2d9',       -- Statusline and tabline section background
	gutter_bg = '#e9e4d8',          -- Number and sign column background
	line_nr = '#6b6459',            -- The digits themselves
	gutter_normal = '#a69e8c',      -- Window separators, tab and space marks
	selection_inactive = '#d8d0be', -- Visual, pmenu, word under cursor
	guide_normal = '#aaa398',       -- Non-text marks and the pmenu thumb

	vcs_added = '#3d7a33',          -- Git added
	vcs_modified = '#1a5b8f',       -- Git changed
	vcs_removed = '#b23a3a',        -- Git removed, trailing whitespace

	vcs_added_bg = '#e2ebdd',       -- Diff added line background
	vcs_removed_bg = '#f2e0dd',     -- Diff removed line background

	ok = '#3d7a33',                 -- Success: passing tests, checked items
	error = '#a52a2a',              -- Errors and breakpoints
	warning = '#9a6400',            -- Warnings and the current search match

	fg_idle = '#847e73',            -- Inactive windows, unused and deprecated code
}

require "highlightgroups".set_hl(c)
