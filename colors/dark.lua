if vim.g.colors_name then
	vim.cmd("hi clear")
end

vim.g.colors_name = "dark"
vim.o.background = "dark"

local c = {
	white = '#ffffff',              -- Text on the Error badge, nothing else

	lsp_inlay_hint = '#8a8a8a',     -- Inlay hints and the pmenu extra column

	accent = '#72b0d0',             -- Eye-catcher: info, match ranges, float titles
	indicator = '#86aec6',          -- Filled chips: mode, cursor position, tab counter
	bg = '#222222',                 -- Editor background, and text on every filled chip
	fg = '#c8c8c8',                 -- Default text

	cursor = '#c8c8c8',             -- The caret block

	tag = '#8ab5b2',                -- Fields, properties, links
	func = '#c9a78c',               -- Functions and directories
	entity = '#a3abdb',             -- Types, modules, tag names
	string = '#9cc093',             -- Strings and prompts
	regexp = '#a0a0a0',             -- Hints, notes, regex
	markup = '#a0a0a0',             -- Markup, exceptions, TODO
	keyword = '#e6e6e6',            -- Keywords, statements, titles
	special = '#e6e6e6',            -- Delimiters and structure
	comment = '#808080',            -- Comments and dimmed labels
	constant = '#c3a3cf',           -- Constants and literals
	operator = '#e6e6e6',           -- Operators
	lsp_parameter = '#8ab5b2',      -- LSP parameter tokens

	line = '#2c2c2c',               -- Cursorline and column band
	panel_bg = '#3a3a3a',           -- Statusline, winbar, fold background
	panel_shadow = '#2e2e2e',       -- Tabline background
	panel_border = '#3a3a3a',       -- Statusline and tabline section background
	gutter_bg = '#282828',          -- Number and sign column background
	line_nr = '#8a8a8a',            -- The digits themselves
	gutter_normal = '#555555',      -- Window separators, tab and space marks
	selection_inactive = '#444444', -- Visual, pmenu, word under cursor
	guide_normal = '#555555',       -- Non-text marks and the pmenu thumb

	vcs_added = '#94c085',          -- Git added
	vcs_modified = '#86aed6',       -- Git changed
	vcs_removed = '#d68080',        -- Git removed, trailing whitespace

	vcs_added_bg = '#2b3427',       -- Diff added line background
	vcs_removed_bg = '#3b2b2b',     -- Diff removed line background

	ok = '#94c085',                 -- Success: passing tests, checked items
	error = '#c95f5f',              -- Errors and breakpoints
	warning = '#d2a65a',            -- Warnings and the current search match

	fg_idle = '#6a6a6a',            -- Inactive windows, unused and deprecated code
}

require "highlightgroups".set_hl(c)
