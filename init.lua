-- Load my pluginmanager
require "pluginmanager".setup()

--
-- Options
--

vim.opt.breakindent = true                                             -- Wrap indent and have the same indent
vim.opt.cursorline = true                                              -- Highlight the text line of the cursor
vim.opt.linebreak = true                                               -- Wrap lines at 'breakat'
vim.opt.preserveindent = true                                          -- Preserve indent structure as much as possible
vim.opt.expandtab = false                                              -- Enable the use of space in tab
vim.opt.shiftwidth = 4                                                 -- Number of space inserted for indentation
vim.opt.tabstop = 4                                                    -- Number of space in a tab
vim.opt.infercase = true                                               -- Infer cases in keyword completion
vim.opt.smartindent = true                                             -- Smarter autoindentation
vim.opt.nrformats = 'alpha,octal,hex,bin'                              -- Enable ctrl+a/x incrementing and decrementing
vim.opt.number = true                                                  -- Show numberline
vim.opt.relativenumber = true                                          -- Show relative numberline
vim.opt.showtabline = 2                                                -- always display tabline
vim.opt.signcolumn = "yes"                                             -- Always show the sign column
vim.opt.termguicolors = true                                           -- Enable 24-bit RGB color in the TUI
vim.opt.wrap = true                                                    -- Disable wrapping of lines longer than the width of window
vim.opt.list = true                                                    -- Enable seeing tabs and spaces
vim.opt.completeopt = { "menuone", "noselect", "preview", "noinsert" } -- Options for insert mode completion
vim.opt.pumheight = 10                                                 -- Height of the pop up menu
vim.opt.mouse = ""                                                     -- Enable mouse support
vim.opt.ignorecase = true                                              -- Case insensitive searching
vim.opt.smartcase = true                                               -- But use sensitive if upper letter is typed
vim.opt.splitbelow = true                                              -- Splitting a new window below the current one
vim.opt.splitright = true                                              -- Splitting a new window at the right of the current one
vim.opt.history = 100                                                  -- Number of commands to remember in a history table
vim.opt.undofile = true                                                -- Enable persistent undo
vim.opt.writebackup = false                                            -- Disable making a backup before overwriting a file
vim.opt.spelllang = { 'en' }                                           -- Use english dictionary
vim.opt.fileencoding = "utf-8"                                         -- File content encoding for the buffer
vim.opt.path:append("**")                                              -- :find will search recursivly

vim.opt.grepprg = "rg --vimgrep"                                       -- Replace grep with ripgrep (faster)
vim.opt.grepformat = "%f:%l:%c:%m"

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevelstart = 99

vim.g.mapleader = " "

vim.g.zig_fmt_parse_errors = 0 -- Don't open quickfix on save

--
-- Colors
--

local colors = {
	-- bg = '#f2eede',
	-- lbg = '#f7f3e3',
	-- black = '#000000',
	-- blue = '#1e6fcc',
	-- green = '#216609',
	-- lgreen = '#dfeacc',
	-- red = '#cc3e28',
	-- grey = '#777777',
	-- dgrey = '#555555',
	-- lgrey1 = '#d8d5c7',
	-- lgrey2 = '#bfbcaf',
	-- lgrey3 = '#aaaaaa',
	-- yellow = '#b58900',
	-- lyellow = '#f2de91',
	-- orange = '#a55000',
	-- purple = '#5c21a5',
	-- white = '#ffffff',
	-- cyan = '#158c86',

	lack = "#708090",
	luster = "#deeeed",
	orange = "#ffaa88",
	yellow = "#abab77",
	green = "#789978",
	blue = "#7788AA",
	red = "#D70000",

	black = "#000000",
	gray1 = "#080808",
	gray2 = "#191919",
	gray3 = "#2a2a2a",
	gray4 = "#444444",
	gray5 = "#555555",
	gray6 = "#7a7a7a",
	gray7 = "#aaaaaa",
	gray8 = "#cccccc",
	gray9 = "#DDDDDD",

	main_background = "#000000",
	menu_background = "#191919",
	popup_background = "#1A1A1A",
	statusline = "#343434",
	comment = "#3A3A3A",
	exception = "#505050",
	keyword = "#666666",
	param = "#8E8E8E",
	whitespace = "#202020",
}

local highlights = {
	-- Text
	Normal = { fg = colors.gray8, bg = colors.main_background },
	Title = { fg = colors.gray5 },
	Whitespace = { fg = colors.whitespace },

	-- Non Text (see :source $VIMRUNTIME/syntax/hitest.vim)
	NonText = { fg = colors.gray5 },

	-- Cursor
	SignColumn = { fg = colors.gray4, bg = colors.main_background },
	CursorLine = { bg = colors.gray2 },
	CursorLineNr = { fg = colors.gray7 },
	LineNr = { fg = colors.gray4 },
	ColorColumn = { bg = colors.gray1 },

	-- Search
	Search = { fg = colors.black, bg = colors.lack },
	CurSearch = { fg = colors.black, bg = colors.gray8 },
	IncSearch = { fg = colors.black, bg = colors.gray8 },
	Substitute = { fg = colors.black, bg = colors.lack },

	-- Visual
	VISUAL = { fg = colors.black, bg = colors.gray8 },
	VISUALNOS = { fg = colors.black, bg = colors.gray8 },

	-- Fold
	Folded = { fg = colors.gray4 },
	FoldColumn = { fg = colors.gray4 },

	-- Status Line
	StatusLine = { fg = colors.gray7, bg = colors.statusline },
	StatusLineNC = { fg = colors.gray4, bg = colors.gray1 },

	-- Tabline
	Tabline = { fg = colors.gray4, bg = colors.gray2 },
	TablineSel = { fg = colors.gray1, bg = colors.gray8 },
	TablineFill = { fg = colors.gray9, bg = colors.statusline },

	-- Float
	NormalFloat = { fg = colors.gray8, bg = colors.main_background },
	FloatBorder = { fg = colors.gray8, bg = colors.main_background },
	FloatTitle = { fg = colors.gray8 },

	-- Menu
	Pmenu = { fg = colors.gray7, bg = colors.menu_background },
	PmenuSbar = { fg = colors.gray3, bg = colors.gray3 },
	PmenuThumb = { fg = colors.gray5, bg = colors.gray5 },
	PmenuSel = { fg = colors.black, bg = colors.gray8 },

	-- Message
	Error = { fg = colors.red },
	ErrorMsg = { fg = colors.red },
	ModeMsg = { fg = colors.luster },
	MoreMsg = { fg = colors.luster },
	MsgArea = { fg = colors.luster },
	WarningMsg = { fg = colors.orange },
	NvimInternalError = { fg = colors.red },
	healthError = { fg = colors.red },
	healthSuccess = { fg = colors.green },
	healthWarning = { fg = colors.orange },

	-- Other
	WinSeparator = { fg = colors.gray4 },
	QuickFixLine = { fg = colors.green },

	-- Syntax
	Identifier = { fg = colors.gray7 },
	Function = { fg = colors.gray7 },
	Type = { fg = colors.gray9 },
	Variable = { fg = colors.gray6 },
	Special = { fg = colors.lack },
	Statement = { fg = colors.gray9 },
	Keyword = { fg = colors.gray9, bold = true },
	Conditial = { fg = colors.gray9 },
	Repeat = { fg = colors.gray9 },
	Label = { fg = colors.gray9 },
	Exception = { fg = colors.gray9 },
	PreProc = { fg = colors.gray9 },

	-- Consts
	String = { fg = colors.lack },
	Character = { fg = colors.lack },
	Constant = { fg = colors.gray7 },
	Number = { fg = colors.gray7 },
	Boolean = { fg = colors.gray7 },
	Float = { fg = colors.gray7 },

	-- Punctuation
	Quote = { fg = colors.lack },
	Operator = { fg = colors.gray6 },
	Delimiter = { fg = colors.gray6 },
	MatchParen = { fg = colors.gray8, bg = colors.lack },

	-- Comment
	Todo = { fg = colors.luster },
	Question = { fg = colors.luster },
	Comment = { fg = colors.gray9, italic = true },
	SpecialComment = { fg = colors.gray9, italic = true },

	-- Diagnostic
	DiagnosticOk = { fg = colors.gray4 },
	DiagnosticHint = { fg = colors.gray4 },
	DiagnosticInfo = { fg = colors.gray4 },
	DiagnosticWarn = { fg = colors.gray4 },
	DiagnosticError = { fg = colors.red },
	DiagnosticDeprecated = { fg = colors.gray4 },
	DiagnosticUnnecessary = { fg = colors.gray4 },
	DiagnosticVirtualTextOk = { fg = colors.gray4 },
	DiagnosticVirtualTextHint = { fg = colors.gray4 },
	DiagnosticVirtualTextInfo = { fg = colors.gray4 },
	DiagnosticVirtualTextWarn = { fg = colors.gray4 },
	DiagnosticVirtualTextErr = { fg = colors.red },
	DiagnosticSignOk = { fg = colors.green },
	DiagnosticSignInfo = { fg = colors.gray6 },
	DiagnosticSignHint = { fg = colors.gray6 },
	DiagnosticSignWarn = { fg = colors.orange },
	DiagnosticSignError = { fg = colors.red },
	DiagnosticSignDeprecated = { fg = colors.orange },
	DiagnosticUnderlineWarn = { fg = colors.orange, undercurl = true },
	DiagnosticUnderlineInfo = { fg = colors.gray6, undercurl = true },
	DiagnosticUnderlineHint = { fg = colors.gray6, undercurl = true },
	DiagnosticUnderlineError = { fg = colors.red, undercurl = true },

	-- File Types
	Directory = { fg = colors.gray8, bold = true },

	-- Plugins
	MiniPickPrompt = { fg = colors.gray8 },
}

for group, opts in pairs(highlights) do
	vim.api.nvim_set_hl(0, group, opts)
end

--
-- Keybindings
--

vim.keymap.set("n", "|", "<cmd>vsplit<cr>", { desc = "Vertical Split" })
vim.keymap.set("n", "\\", "<cmd>split<cr>", { desc = "Horizontal Split" })

vim.keymap.set("n", "<c-k>", "<cmd>wincmd k<cr>", { desc = "Move to top split" })
vim.keymap.set("n", "<c-j>", "<cmd>wincmd j<cr>", { desc = "Move to bottom split" })
vim.keymap.set("n", "<c-h>", "<cmd>wincmd h<cr>", { desc = "Move to left split" })
vim.keymap.set("n", "<c-l>", "<cmd>wincmd l<cr>", { desc = "Move to right split" })
vim.keymap.set("n", "<c-Up>", "<cmd>resize +2<CR>", { desc = "Resize split up" })
vim.keymap.set("n", "<c-Down>", "<cmd>resize -2<CR>", { desc = "Resize split down" })
vim.keymap.set("n", "<c-Left>", "<cmd>vertical resize +2<CR>", { desc = "Resize split left" })
vim.keymap.set("n", "<c-Right>", "<cmd>vertical resize -2<CR>", { desc = "Resize split right" })

vim.keymap.set("n", "<a-b>", "<cmd>bn<cr>", { desc = "Move to right buffer or loop" })
vim.keymap.set("n", "<a-B>", "<cmd>bp<cr>", { desc = "Move to left buffer or loop" })
vim.keymap.set("n", "<a-q>", "<cmd>cnext<cr>", { desc = "Move to next quickfix item" })
vim.keymap.set("n", "<a-Q>", "<cmd>cprevious<cr>", { desc = "Move to previous quickfix item" })
vim.keymap.set("n", "<a-w>", "<cmd>lnext<cr>", { desc = "Move to next location list item" })
vim.keymap.set("n", "<a-W>", "<cmd>lprevious<cr>", { desc = "Move to previous location list item" })
vim.keymap.set({ "n", "v" }, "<a-P>", "{", { desc = "Move to previous paragraph" })
vim.keymap.set({ "n", "v" }, "<a-p>", "}", { desc = "Move to next paragraph" })

vim.keymap.set("n", "<F10>",
	function()
		for _, win in ipairs(vim.fn.getwininfo()) do
			if win.loclist == 1 then
				vim.cmd("lclose")
				return
			end
		end
		vim.cmd("lopen")
	end, { desc = "Close location list" })
vim.keymap.set("n", "<F11>",
	function()
		for _, win in ipairs(vim.fn.getwininfo()) do
			if win.quickfix == 1 then
				vim.cmd("cclose")
				return
			end
		end
		vim.cmd("copen")
	end, { desc = "Close quickfix list" })
vim.keymap.set("n", "<F12>", "<cmd>bp | sp | bn | bd!<cr>", { desc = "Delete current buffer without messing up split" })

vim.keymap.set("v", "<c-c>", '"+y', { desc = "Copy selected to clipboard." })

vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "unindent line" })
vim.keymap.set("v", "<Tab>", ">gv", { desc = "indent line" })

vim.keymap.set("n", "<esc>", "<cmd>noh<CR>", { desc = "Stop search with ESC" })

vim.keymap.set("n", "<leader>Z", function()
	vim.opt_local.spell = not (vim.opt_local.spell:get())
	print("spell: " .. tostring(vim.opt_local.spell:get()))
end, { desc = "Enable spell checking" })
vim.keymap.set("n", "ze", function()
	vim.opt.spelllang = { 'en' }
	print("lang: english")
end, { desc = "Set spellcheck to english" })
vim.keymap.set("n", "zd", function()
	vim.opt.spelllang = { 'de' }
	print("lang: german")
end, { desc = "Set spellcheck to german" })
vim.keymap.set("n", "<leader>z", "z=", { desc = "Spelling suggestions" })

vim.keymap.set({ "n", "x" }, "<a-d>", function() vim.diagnostic.jump { count = 1, float = true } end,
	{ desc = "Next Diagnostic" })
vim.keymap.set({ "n", "x" }, "<a-D>", function() vim.diagnostic.jump { count = -1, float = true } end,
	{ desc = "Previous Diagnostic" })

vim.keymap.set('n', 'grd', vim.lsp.buf.definition, { desc = "Goto definition" })
vim.keymap.set('n', '<a-i>', vim.lsp.buf.format, { desc = "Format document" })

--
-- Autocmds
--

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local usercmd = vim.api.nvim_create_user_command

usercmd("Open", function(opts) vim.system({ "xdg-open", opts.args }, { stdout = false, detach = true }) end,
	{ nargs = 1, complete = "file_in_path", desc = "Open file using xdg-open" })

autocmd("TextYankPost", {
	desc = "Highlight yanked text",
	group = augroup("highlightyank", { clear = true }),
	pattern = "*",
	callback = function() vim.highlight.on_yank() end,
})

autocmd("FileType", {
	desc = "Unlist quickfist buffers",
	group = augroup("unlist_quickfist", { clear = true }),
	pattern = "qf",
	callback = function() vim.opt_local.buflisted = false end,
})

autocmd("QuickFixCmdPost", {
	pattern = "lgrep",
	callback = function()
		vim.cmd("lopen")
	end,
})
