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

vim.opt.foldlevelstart = 99

vim.o.completeopt = "menuone,noinsert,nosort"

vim.g.mapleader = " "
vim.g.zig_fmt_parse_errors = 0 -- Don't open quickfix on save
vim.g.no_plugin_maps = true

keymap = {
	-- Duck
	DuckCreate = "<leader>dd",
	DuckDestroy = "<leader>dk",
	DuckDestroyAll = "<leader>da",

	-- Splitting
	VerticalSplit = "|",
	HorizontalSplit = "\\",

	-- Window Management
	JumpUpWindow = "<c-k>",
	JumpDownWindow = "<c-j>",
	JumpLeftWindow = "<c-h>",
	JumpRightWindow = "<c-l>",
	ResizeUpWindow = "<c-Up>",
	ResizeDownWindow = "<c-Down>",
	ResizeLeftWindow = "<c-Left>",
	ResizeRightWindow = "<c-Right>",
	ExitWindow = "<leader>q",

	-- Alt Walking
	NextBuffer = "<a-b>",
	PrevBuffer = "<a-B>",
	NextQuickfix = "<a-q>",
	PrevQuickfix = "<a-Q>",
	NextLocation = "<a-o>",
	PrevLocation = "<a-O>",
	NextParagraph = "<a-p>",
	PrevParagraph = "<a-P>",
	NextDiagnostic = "<a-d>",
	PrevDiagnostic = "<a-D>",

	-- Quickfix/Locationlist
	LocationToggle = "<F10>",
	QuickfixToggle = "<F11>",

	-- Buffer Management
	BufferDelete = "<F12>",

	-- Clipboard
	SysClipBoardCopy = "<c-c>",

	-- Search
	FilePick = "<leader>f",
	GrepPick = "<leader>G",
	BufferPick = "<leader>b",
	Filesytem = "<leader>s",

	-- Autocomplete
	CompleteFirst = "<c-space>",
	CompleteSecond = "<a-space>",
	ComplateUp = "<c-f>",
	ComplateDown = "<c-b>",

	-- Debugger
	DAPContinue = "<F1>",
	DAPstepout = "<F2>",
	DAPstepover = "<F3>",
	DAPstepinto = "<F4>",
	DAPrepl = "<F5>",
	DAPtogglebreak = "<leader>n",
	DAPtogglescope = "<leader>m",
	DAPtoggleframe = "<leader>M",
	DAPreset = "<leader>N",

	-- Building
	BuildProj = "<F7>",
	RunProj = "<F8>",
	TestProj = "<F9>",

	-- Jump
	JumpWord = "s",
	JumpChar = "s",
	JumpRepeat = ";",

	-- Trailwhitespace
	TrailRemove = "<leader>p",
	TrailRemoveAll = "<leader>P",

	-- Surrounding
	SurroundAdd = "ma",
	SurroundDelete = "md",
	SurroundFindFront = "mf",
	SurroundFindBack = "mF",
	SurroundHighlight = "mh",
	SurroundReplace = "mr",

	-- Spelling
	SpellToggle = "<leader>Z",
	SpellSwitchEn = "ze",
	SpellSwitchDe = "zd",
	SpellSuggest = "<leader>z",

	-- Git
	GitToggleOverlay = "<leader>gg",
	GitTrackLine = "<leader>gk",
	GitBranchDiff = "<leader>gd",
	GitApply = "<leader>ga",
	GitApplyAll = "<leader>gA",
	GitReset = "<leader>gr",
	GitStatus = "<leader>gs",
	GitCommit = "<leader>gc",
	GitCommitAmend = "<leader>gC",
	GitLog = "<leader>gl",
	Lazygit = "<leader>v",
	NextChange = "<a-g>",
	PrevChange = "<a-G>",

	-- LSP
	LSPDefinition = "gd",
	LSPDeclaration = "gD",
	LSPRename = "gr",
	LSPReferences = "gR",
	LSPImplementation = "gi",
	LSPHover = "K",
	LSPCodeAction = "ga",
	LSPSymbolPick = "gs",
	LSPFormat = "<a-i>",

	-- Text Movement
	MoveLeft = "<a-h>",
	MoveRight = "<a-l>",
	MoveDown = "<a-j>",
	MoveUp = "<a-k>",
	MoveLineLeft = "<a-h>",
	MoveLineRight = "<a-l>",
	MoveLineDown = "<a-j>",
	MoveLineUp = "<a-k>",

	-- External
	Terminal = "<leader>t",
}

vim.pack.add({
	"https://github.com/nvim-mini/mini.nvim",
	"https://github.com/Darazaki/indent-o-matic",
	"https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mfussenegger/nvim-dap",
	"https://github.com/tamton-aquib/duck.nvim",
})

require "mini.extra".setup() -- Extras
