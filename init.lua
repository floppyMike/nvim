local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local usercmd = vim.api.nvim_create_user_command

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

vim.opt.foldlevelstart = 99

vim.g.mapleader = " "
vim.g.zig_fmt_parse_errors = 0 -- Don't open quickfix on save

--
-- Colors
--

vim.cmd.colorscheme "ice"

--
-- Keymap
--

local keymap = {
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

	-- Alt Walking
	NextBuffer = "<a-b>",
	PrevBuffer = "<a-B>",
	NextQuickfix = "<a-q>",
	PrevQuickfix = "<a-Q>",
	NextLocation = "<a-l>",
	PrevLocation = "<a-L>",
	NextParagraph = "<a-p>",
	PrevParagraph = "<a-P>",
	NextDiagnostic = "<a-d>",
	PrevDiagnostic = "<a-D>",
	NextChange = "<a-g>",
	PrevChange = "<a-G>",

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
	GitToggleOverlay = "<leader>hh",
	GitTrackLine = "<leader>hk",
	GitBranchDiff = "<leader>hd",
	GitApply = "<leader>ha",
	GitReset = "<leader>hr",

	-- LSP
	LSPDefinition = "grd",
	LSPFormat = "<a-i>",
	LSPSymbolPick = "gO",

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
	Lazygit = "<leader>g",
}

--
-- Basic
--

autocmd("FileType", { -- Quicklist buffers don't appear in bufferlist
	desc = "Unlist quickfist buffers",
	group = augroup("unlist_quickfist", { clear = true }),
	pattern = "qf",
	callback = function() vim.opt_local.buflisted = false end,
})

vim.keymap.set("n", keymap.VerticalSplit, "<cmd>vsplit<cr>", { desc = "Vertical Split" })
vim.keymap.set("n", keymap.HorizontalSplit, "<cmd>split<cr>", { desc = "Horizontal Split" })
vim.keymap.set("n", keymap.JumpUpWindow, "<cmd>wincmd k<cr>", { desc = "Move to top split" })
vim.keymap.set("n", keymap.JumpDownWindow, "<cmd>wincmd j<cr>", { desc = "Move to bottom split" })
vim.keymap.set("n", keymap.JumpLeftWindow, "<cmd>wincmd h<cr>", { desc = "Move to left split" })
vim.keymap.set("n", keymap.JumpRightWindow, "<cmd>wincmd l<cr>", { desc = "Move to right split" })
vim.keymap.set("n", keymap.ResizeUpWindow, "<cmd>resize +2<CR>", { desc = "Resize split up" })
vim.keymap.set("n", keymap.ResizeDownWindow, "<cmd>resize -2<CR>", { desc = "Resize split down" })
vim.keymap.set("n", keymap.ResizeLeftWindow, "<cmd>vertical resize +2<CR>", { desc = "Resize split left" })
vim.keymap.set("n", keymap.ResizeRightWindow, "<cmd>vertical resize -2<CR>", { desc = "Resize split right" })
vim.keymap.set("n", keymap.NextBuffer, "<cmd>bn<cr>", { desc = "Move to right buffer or loop" })
vim.keymap.set("n", keymap.PrevBuffer, "<cmd>bp<cr>", { desc = "Move to left buffer or loop" })
vim.keymap.set("n", keymap.NextQuickfix, "<cmd>cnext<cr>", { desc = "Move to next quickfix item" })
vim.keymap.set("n", keymap.PrevQuickfix, "<cmd>cprevious<cr>", { desc = "Move to previous quickfix item" })
vim.keymap.set("n", keymap.NextLocation, "<cmd>lnext<cr>", { desc = "Move to next location list item" })
vim.keymap.set("n", keymap.PrevLocation, "<cmd>lprevious<cr>", { desc = "Move to previous location list item" })
vim.keymap.set({ "n", "v" }, keymap.NextParagraph, "}", { desc = "Move to next paragraph" })
vim.keymap.set({ "n", "v" }, keymap.PrevParagraph, "{", { desc = "Move to previous paragraph" })
vim.keymap.set("v", keymap.SysClipBoardCopy, '"+y', { desc = "Copy selected to clipboard." })
vim.keymap.set("n", "<esc>", "<cmd>noh<CR>", { desc = "Stop search with ESC" })


vim.keymap.set("n", keymap.LocationToggle,
	function()
		for _, win in ipairs(vim.fn.getwininfo()) do
			if win.loclist == 1 then
				vim.cmd("lclose")
				return
			end
		end
		vim.cmd("lopen")
	end, { desc = "Close location list" })

vim.keymap.set("n", keymap.QuickfixToggle,
	function()
		for _, win in ipairs(vim.fn.getwininfo()) do
			if win.quickfix == 1 then
				vim.cmd("cclose")
				return
			end
		end
		vim.cmd("copen")
	end, { desc = "Close quickfix list" })

usercmd("Open", function(opts) vim.system({ "xdg-open", opts.args }, { stdout = false, detach = true }) end, -- Open with default app
	{ nargs = 1, complete = "file_in_path", desc = "Open file using xdg-open" })

--
-- Plugins
--

vim.pack.add({
	"https://github.com/nvim-mini/mini.nvim",
	"https://github.com/Darazaki/indent-o-matic",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mfussenegger/nvim-dap",
	"https://github.com/tamton-aquib/duck.nvim",
})

--
-- UI
--

require "mini.icons".setup()      -- Add nice icons
require "mini.statusline".setup() -- Setup minimal but complete statusline
require "mini.tabline".setup()    -- Show buffers as "tabs"
require "mini.notify".setup()     -- Top right notifications
require "mini.files".setup()
require "mini.extra".setup()

require "mini.pick".setup {
	options = { content_from_bottom = true },
	source = { choose_marked = function(items) MiniPick.default_choose_marked(items, { list_type = "location" }) end }
}

vim.keymap.set("n", keymap.FilePick, MiniPick.builtin.files)
vim.keymap.set("n", keymap.GrepPick, MiniPick.builtin.grep)
vim.keymap.set("n", keymap.BufferPick, MiniPick.builtin.buffers)
vim.keymap.set("n", keymap.Filesytem, MiniFiles.open)

vim.keymap.set("n", keymap.Terminal, function() vim.system({ "st" }, { stdout = false, detach = true }) end,
	{ desc = "Open new terminal in same directory.", silent = true })

vim.keymap.set("n", keymap.Lazygit,
	function() vim.system({ "st", "-e", "lazygit" }, { stdout = false, detach = true }) end,
	{ desc = "Open new terminal in same directory.", silent = true })

--
-- Buffer Management
--

vim.keymap.set("n", keymap.BufferDelete, require "mini.bufremove".wipeout,
	{ desc = "Delete current buffer without messing up split" })

--
-- Spelling
--

vim.keymap.set("n", keymap.SpellSuggest, MiniExtra.pickers.spellsuggest)
vim.keymap.set("n", "<leader>z", "z=", { desc = "Spelling suggestions" })

vim.keymap.set("n", keymap.SpellToggle, function()
	vim.opt_local.spell = not (vim.opt_local.spell:get())
	print("spell: " .. tostring(vim.opt_local.spell:get()))
end, { desc = "Enable spell checking" })

vim.keymap.set("n", keymap.SpellSwitchEn, function()
	vim.opt.spelllang = { 'en' }
	print("lang: english")
end, { desc = "Set spellcheck to english" })

vim.keymap.set("n", keymap.SpellSwitchDe, function()
	vim.opt.spelllang = { 'de' }
	print("lang: german")
end, { desc = "Set spellcheck to german" })

--
-- Auto indent
--

require 'indent-o-matic'.setup {}

--
-- LSP Management
--

require "mason".setup()
require "mason-lspconfig".setup()

--
-- Completion
--

vim.o.completeopt = "menuone,noinsert,nosort"

require "mini.completion".setup {
	mappings = {
		force_twostep = keymap.CompleteFirst,
		force_fallback = keymap.CompleteSecond,
		scroll_down = keymap.ComplateUp,
		scroll_up = keymap.ComplateDown,
	}
}

autocmd("CompleteDone", {
	callback = function()
		if vim.v.event.complete_type == 'files' and vim.v.event.reason == 'accept' then
			vim.api.nvim_feedkeys("\24\6", "m", false)
		end
	end
})

--
-- Git
--

require "mini.git".setup()
require "mini.diff".setup {
	view = {
		style = "sign",
		signs = { add = '+', change = '~', delete = '-' }
	},
	mappings = {
		apply = keymap.GitApply,
		reset = keymap.GitReset,
		goto_first = '',
		goto_prev = keymap.PrevChange,
		goto_next = keymap.NextChange,
		goto_last = '',
	},
	options = {
		wrap_goto = true,
	},
}

vim.keymap.set("n", keymap.GitToggleOverlay, MiniDiff.toggle_overlay)
vim.keymap.set("n", keymap.GitTrackLine, MiniGit.show_at_cursor)

vim.keymap.set("n", keymap.GitBranchDiff, function()
	local c1 = vim.fn.input("From Commit: ")
	vim.cmd("Git diff " .. c1 .. "..HEAD")
end)

--
-- Duck
--

vim.keymap.set('n', keymap.DuckCreate, function() require("duck").hatch("ඞ") end, { desc = "Spawn a pet amogus" })
vim.keymap.set('n', keymap.DuckDestroy, function() require("duck").cook() end, { desc = "Kill a pet amogus" })
vim.keymap.set('n', keymap.DuckDestroyAll, function() require("duck").cook_all() end, { desc = "Kill all pet amogus" })

--
-- LSP Configuration
--

vim.keymap.set('n', keymap.LSPDefinition, vim.lsp.buf.definition, { desc = "Goto definition" })
vim.keymap.set('n', keymap.LSPFormat, vim.lsp.buf.format, { desc = "Format document" })
vim.keymap.set("n", keymap.LSPSymbolPick, function() MiniExtra.pickers.lsp({ scope = "document_symbol" }) end)

vim.keymap.set({ "n", "x" }, keymap.NextDiagnostic, function() vim.diagnostic.jump { count = 1, float = true } end,
	{ desc = "Move to next Diagnostic" })

vim.keymap.set({ "n", "x" }, keymap.PrevDiagnostic, function() vim.diagnostic.jump { count = -1, float = true } end,
	{ desc = "Move to previous Diagnostic" })


vim.lsp.config("lua_ls", {
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if path ~= vim.fn.stdpath('config') and (vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc')) then
				return
			end
		end
		client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
			runtime = {
				version = 'LuaJIT',
				path = {
					'lua/?.lua',
					'lua/?/init.lua',
				},
			},
			-- Make the server aware of Neovim runtime files
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME
				}
			}
		})
	end,
	settings = {
		Lua = {}
	}
})

vim.lsp.config("texlab", {
	on_attach = function(_, bufnr)
		local opts = { silent = true, buffer = bufnr }

		opts.desc = "Build project"
		vim.keymap.set('n', keymap.BuildProj, '<cmd>make<cr>', opts)
	end,
})

vim.lsp.config("clangd", {
	cmd = { "clangd", "--background-index", "--clang-tidy" },
	on_attach = function(_, bufnr)
		local opts = { silent = true, buffer = bufnr }

		opts.desc = "Build project"
		vim.keymap.set('n', keymap.BuildProj, function()
			vim.o.makeprg = "cmake --build build/ --parallel"
			vim.cmd("make!")
		end, opts)
	end,
})

vim.lsp.config("zls", {
	on_attach = function(_, bufnr)
		local opts = { silent = true, buffer = bufnr }

		opts.desc = "Build project"
		vim.keymap.set('n', keymap.BuildProj, function()
			vim.o.makeprg = "zig build $*"
			vim.cmd("make!")
		end, opts)

		opts.desc = "Test project"
		vim.keymap.set('n', keymap.TestProj, function()
			vim.o.makeprg = "zig build test $*"
			vim.cmd("make!")
		end, opts)
	end
})

vim.lsp.config("rust_analyzer", {
	on_attach = function(_, bufnr)
		local opts = { silent = true, buffer = bufnr }

		opts.desc = "Build project"
		vim.keymap.set('n', keymap.BuildProj, "<cmd>make! build<cr>", opts)
	end
})

--
-- Debugger
--

local dapcfg = require "dapconfig"

local dap = require "dap"
local dapwidgets = require "dap.ui.widgets"
local scope = dapwidgets.sidebar(dapwidgets.scopes, { width = 75 })
local frame = dapwidgets.sidebar(dapwidgets.frames, { width = 75 })

dap.adapters.lldb = {
	type = "executable",
	command = "lldb-dap",
	name = "lldb",
}

dap.configurations.zig = {
	{
		name = "launch",
		type = "lldb",
		request = "launch",
		program = function() return dapcfg.getProgram("zig-out/bin/" .. vim.fs.basename(vim.fn.getcwd())) end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = dapcfg.getArgs,
	},
}

vim.keymap.set("n", keymap.DAPContinue, dap.continue)
vim.keymap.set("n", keymap.DAPstepout, dap.step_out)
vim.keymap.set("n", keymap.DAPstepover, dap.step_over)
vim.keymap.set("n", keymap.DAPstepinto, dap.step_into)
vim.keymap.set("n", keymap.DAPrepl, function() dap.repl.toggle({ height = 15 }) end)
vim.keymap.set("n", keymap.DAPtogglebreak, dap.toggle_breakpoint)
vim.keymap.set("n", keymap.DAPtogglescope, scope.toggle)
vim.keymap.set("n", keymap.DAPtoggleframe, frame.toggle)

vim.keymap.set("n", keymap.DAPreset, function()
	vim.notify("Reset DAP configuration")
	dapcfg.reset()
end)

--
-- Language Syntax & Semantics Configuration
--

vim.g.no_plugin_maps = true

require "nvim-treesitter".setup()

autocmd("FileType", {
	pattern = { "c", "cpp", "zig", "rust", "lua", "java" },
	callback = function()
		vim.treesitter.start()
		vim.wo[0][0].foldmethod = 'expr'
		vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

--
-- Pairs
--

require "mini.pairs".setup() -- Auto add matching bracket pair

--
-- Trailing Whitespace
--

require "mini.trailspace".setup() -- See bad trailing whitespace
vim.keymap.set("n", keymap.TrailRemove, MiniTrailspace.trim, { desc = "Remove trailing whitespace on line" })
vim.keymap.set("n", keymap.TrailRemoveAll, MiniTrailspace.trim_last_lines, { desc = "Remove all trailing whitespace" })

--
-- Jumpy "t"/"f"
--

require "mini.jump".setup {
	mappings = {
		repeated_jump = keymap.JumpRepeat,
	},
}

--
-- Editor Colors
--

require "mini.hipatterns".setup { -- Add TODO and hex colors
	highlighters = {
		todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
		hex_color = require('mini.hipatterns').gen_highlighter.hex_color(),
	}
}

--
-- Surround Operation
--

require "mini.surround".setup { -- Add surround text with functionality
	mappings = {
		add = keymap.SurroundAdd,
		delete = keymap.SurroundDelete,
		find = keymap.SurroundFindFront,
		find_left = keymap.SurroundFindBack,
		highlight = keymap.SurroundHighlight,
		replace = keymap.SurroundReplace,
	},
}

--
-- Extended "a"/"i"
--

local ai = require "mini.ai"
ai.setup {
	custom_textobjects = {
		o = ai.gen_spec.treesitter({
			a = { '@block.outer', '@conditional.outer', '@loop.outer' },
			i = { '@block.inner', '@conditional.inner', '@loop.inner' },
		}, {}),
		F = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }, {}),
		c = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }, {}),
		e = {
			{
				"%u[%l%d]+%f[^%l%d]",
				"%f[%S][%l%d]+%f[^%l%d]",
				"%f[%P][%l%d]+%f[^%l%d]",
				"^[%l%d]+%f[^%l%d]",
				"%f[%S][%w]+%f[^%w]",
				"%f[%P][%w]+%f[^%w]",
				"^%w+%f[^%w]",
			},
			"^().*()$",
		},
	},
}

--
-- Jump
--

local Jump2d = require("mini.jump2d")
Jump2d.setup({ mappings = { start_jumping = "" } })

vim.keymap.set("n", keymap.JumpWord, function()
	local builtin = Jump2d.builtin_opts.word_start
	builtin.view = { n_steps_ahead = 10 }
	Jump2d.start(builtin)
end, { desc = "Start jumping", silent = true })

vim.keymap.set({ "x", "o" }, keymap.JumpChar, function()
	local builtin = Jump2d.builtin_opts.single_character
	Jump2d.start(builtin)
end, { desc = "Start jumping", silent = true })

--
-- Yank Highlight
--

autocmd("TextYankPost", { -- Highlight on yank
	desc = "Highlight yanked text",
	group = augroup("highlightyank", { clear = true }),
	pattern = "*",
	callback = function() vim.highlight.on_yank() end,
})

--
-- Text Move
--

require "mini.move".setup {
	mappings = {
		left = keymap.MoveLeft,
		right = keymap.MoveRight,
		down = keymap.MoveDown,
		up = keymap.MoveUp,
		line_left = keymap.MoveLineLeft,
		line_right = keymap.MoveLineRight,
		line_down = keymap.MoveLineDown,
		line_up = keymap.MoveLineUp,
	},
}
