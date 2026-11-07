if vim.g.colors_name then
	vim.cmd("hi clear")
end

vim.g.colors_name = "light"
vim.o.background = "light"

local c = {
	white = '#ffffff',              -- Text on the Error badge, nothing else

	lsp_inlay_hint = '#5c5c5c',     -- Inlay hints and the pmenu extra column

	accent = '#00688f',             -- Eye-catcher: info, match ranges, float titles
	indicator = '#005577',          -- Filled chips: mode, cursor position, tab counter
	bg = '#f4f4f4',                 -- Editor background, and text on every filled chip
	fg = '#333333',                 -- Default text

	cursor = '#333333',             -- The caret block

	tag = '#458282',                -- Fields, properties, links
	func = '#735040',               -- Functions and directories
	entity = '#070783',             -- Types, modules, tag names
	string = '#00733b',             -- Strings and prompts
	regexp = '#5c5c5c',             -- Hints, notes, regex
	markup = '#5c5c5c',             -- Markup, exceptions, TODO
	keyword = '#1a1a1a',            -- Keywords, statements, titles
	special = '#1a1a1a',            -- Delimiters and structure
	comment = '#8a8a8a',            -- Comments and dimmed labels
	constant = '#660e7a',           -- Constants and literals
	operator = '#1a1a1a',           -- Operators
	lsp_parameter = '#458282',      -- LSP parameter tokens

	line = '#ececec',               -- Cursorline and column band
	panel_bg = '#c4c4c4',           -- Statusline, winbar, fold background
	panel_shadow = '#d6d6d6',       -- Tabline background
	panel_border = '#c4c4c4',       -- Statusline and tabline section background
	gutter_bg = '#e5e5e5',          -- Number and sign column background
	line_nr = '#5c5c5c',            -- The digits themselves
	gutter_normal = '#9a9a9a',      -- Window separators, tab and space marks
	selection_inactive = '#cccccc', -- Visual, pmenu, word under cursor
	guide_normal = '#9a9a9a',       -- Non-text marks and the pmenu thumb

	vcs_added = '#4a7a2a',          -- Git added
	vcs_modified = '#1a5b8f',       -- Git changed
	vcs_removed = '#a03232',        -- Git removed, trailing whitespace

	vcs_added_bg = '#e4efdc',       -- Diff added line background
	vcs_removed_bg = '#f6e2e2',     -- Diff removed line background

	ok = '#4a7a2a',                 -- Success: passing tests, checked items
	error = '#a03232',              -- Errors and breakpoints
	warning = '#9a6a00',            -- Warnings and the current search match

	fg_idle = '#8a8a8a',            -- Inactive windows, unused and deprecated code
}

require "highlightgroups".set_hl(c)
