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
-- Plugins
--

vim.pack.add({
	"https://github.com/nvim-mini/mini.nvim",
	"https://github.com/Darazaki/indent-o-matic",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/saghen/blink.cmp",
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

--
-- Picker
--

require "mini.extra".setup()
require "mini.pick".setup {
	options = { content_from_bottom = true },
	source = { choose_marked = function(items) MiniPick.default_choose_marked(items, { list_type = "location" }) end }
}

--
-- File Explorer
--

require "mini.files".setup()

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

require "blink.cmp".setup {
	sources = {
		default = { "lsp", "path", "snippets", "buffer" }
	},
	fuzzy = {
		implementation = "lua"
	},
	signature = {
		enabled = true
	},
	completion = {
		documentation = { auto_show = true },
	}
}

--
-- Git (includes keybinds)
--

require "mini.git".setup()
require "mini.diff".setup {
	view = {
		style = "sign",
		signs = { add = '+', change = '~', delete = '-' }
	},
	mappings = {
		apply = '<leader>ha',
		reset = '<leader>hr',
		goto_first = '',
		goto_prev = '<a-H>',
		goto_next = '<a-h>',
		goto_last = '',
	},
	options = {
		wrap_goto = true,
	},
}

--
-- LSP Configuration
--

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
		vim.keymap.set('n', '<F7>', '<cmd>make<cr>', opts)
	end,
})

vim.lsp.config("clangd", {
	cmd = { "clangd", "--background-index", "--clang-tidy" },
	on_attach = function(_, bufnr)
		local opts = { silent = true, buffer = bufnr }

		opts.desc = "Build project"
		vim.keymap.set('n', '<F7>', function()
			vim.o.makeprg = "cmake --build build/ --parallel"
			vim.cmd("make!")
		end, opts)
	end,
})

vim.lsp.config("zls", {
	on_attach = function(_, bufnr)
		local opts = { silent = true, buffer = bufnr }

		opts.desc = "Build project"
		vim.keymap.set('n', '<F7>', function()
			vim.o.makeprg = "zig build $*"
			vim.cmd("make!")
		end, opts)

		opts.desc = "Test project"
		vim.keymap.set('n', '<F8>', function()
			vim.o.makeprg = "zig build test $*"
			vim.cmd("make!")
		end, opts)
	end
})

vim.lsp.config("rust_analyzer", {
	on_attach = function(_, bufnr)
		local opts = { silent = true, buffer = bufnr }

		opts.desc = "Build project"
		vim.keymap.set('n', '<F7>', "<cmd>make! build<cr>", opts)
	end
})

vim.lsp.config("nixd", {
	on_attach = function(_, bufnr)
		vim.keymap.set('n', '<a-i>', "<cmd>%!alejandra -qq<cr>",
			{ silent = true, buffer = bufnr, desc = "Format document" })
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

--
-- Language Syntax & Semantics Configuration
--

autocmd("FileType", {
	pattern = { "<filetype>" },
	callback = function()
		vim.treesitter.start() -- Highlighting

		-- Code Folding
		vim.wo[0][0].foldmethod = "expr"
		vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
	end,
})

--
-- Text Editor (includes keybinds)
--

require "mini.hipatterns".setup { -- Add TODO and hex colors
	highlighters = {
		todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
		hex_color = require('mini.hipatterns').gen_highlighter.hex_color(),
	}
}

require "mini.surround".setup { -- Add surround text with functionality
	mappings = {
		add = 'ma',
		delete = 'md',
		find = 'mf',
		find_left = 'mF',
		highlight = 'mh',
		replace = 'mr',
		update_n_lines = 'mn',
	},
}

local ai = require "mini.ai"
ai.setup { -- Extends "a"/"i" text objects
	mappings = {
		goto_left = '<a-G>',
		goto_right = '<a-g>',
	},
	custom_textobjects = {
		o = ai.gen_spec.treesitter({
			a = { '@block.outer', '@conditional.outer', '@loop.outer' },
			i = { '@block.inner', '@conditional.inner', '@loop.inner' },
		}, {}),
		f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }, {}),
		c = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }, {}),
	},
}

require "mini.pairs".setup() -- Auto add matching bracket pair

local Jump2d = require("mini.jump2d")
Jump2d.setup({ mappings = { start_jumping = "" } }) -- Quick Jump
local jump_word = function()
	local builtin = Jump2d.builtin_opts.word_start
	builtin.view = { n_steps_ahead = 10 }
	Jump2d.start(builtin)
end
local jump_char = function()
	local builtin = Jump2d.builtin_opts.single_character
	Jump2d.start(builtin)
end


autocmd("TextYankPost", { -- Highlight on yank
	desc = "Highlight yanked text",
	group = augroup("highlightyank", { clear = true }),
	pattern = "*",
	callback = function() vim.highlight.on_yank() end,
})

--
-- Keybindings
--

-- Pet Duck
vim.keymap.set('n', '<leader>wd', function() require("duck").hatch("ඞ") end, {})
vim.keymap.set('n', '<leader>wk', function() require("duck").cook() end, {})
vim.keymap.set('n', '<leader>wa', function() require("duck").cook_all() end, {})

-- Splitting
vim.keymap.set("n", "|", "<cmd>vsplit<cr>", { desc = "Vertical Split" })
vim.keymap.set("n", "\\", "<cmd>split<cr>", { desc = "Horizontal Split" })

-- Window Management
vim.keymap.set("n", "<c-k>", "<cmd>wincmd k<cr>", { desc = "Move to top split" })
vim.keymap.set("n", "<c-j>", "<cmd>wincmd j<cr>", { desc = "Move to bottom split" })
vim.keymap.set("n", "<c-h>", "<cmd>wincmd h<cr>", { desc = "Move to left split" })
vim.keymap.set("n", "<c-l>", "<cmd>wincmd l<cr>", { desc = "Move to right split" })
vim.keymap.set("n", "<c-Up>", "<cmd>resize +2<CR>", { desc = "Resize split up" })
vim.keymap.set("n", "<c-Down>", "<cmd>resize -2<CR>", { desc = "Resize split down" })
vim.keymap.set("n", "<c-Left>", "<cmd>vertical resize +2<CR>", { desc = "Resize split left" })
vim.keymap.set("n", "<c-Right>", "<cmd>vertical resize -2<CR>", { desc = "Resize split right" })

-- Alt Walking
vim.keymap.set("n", "<a-b>", "<cmd>bn<cr>", { desc = "Move to right buffer or loop" })
vim.keymap.set("n", "<a-B>", "<cmd>bp<cr>", { desc = "Move to left buffer or loop" })
vim.keymap.set("n", "<a-q>", "<cmd>cnext<cr>", { desc = "Move to next quickfix item" })
vim.keymap.set("n", "<a-Q>", "<cmd>cprevious<cr>", { desc = "Move to previous quickfix item" })
vim.keymap.set("n", "<a-w>", "<cmd>lnext<cr>", { desc = "Move to next location list item" })
vim.keymap.set("n", "<a-W>", "<cmd>lprevious<cr>", { desc = "Move to previous location list item" })
vim.keymap.set({ "n", "v" }, "<a-P>", "{", { desc = "Move to previous paragraph" })
vim.keymap.set({ "n", "v" }, "<a-p>", "}", { desc = "Move to next paragraph" })
vim.keymap.set({ "n", "x" }, "<a-d>", function() vim.diagnostic.jump { count = 1, float = true } end,
	{ desc = "Next Diagnostic" })
vim.keymap.set({ "n", "x" }, "<a-D>", function() vim.diagnostic.jump { count = -1, float = true } end,
	{ desc = "Previous Diagnostic" })

-- Quicklist/Locationlist
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

-- Buffer Management
vim.keymap.set("n", "<F12>", "<cmd>bp | sp | bn | bd!<cr>", { desc = "Delete current buffer without messing up split" })

-- Clipboard
vim.keymap.set("v", "<c-c>", '"+y', { desc = "Copy selected to clipboard." })

-- Indentation
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "unindent line" })
vim.keymap.set("v", "<Tab>", ">gv", { desc = "indent line" })

-- Search
vim.keymap.set("n", "<esc>", "<cmd>noh<CR>", { desc = "Stop search with ESC" })
vim.keymap.set("n", "<leader>f", MiniPick.builtin.files)
vim.keymap.set("n", "<leader>g", MiniPick.builtin.grep)
vim.keymap.set("n", "<leader>b", MiniPick.builtin.buffers)
vim.keymap.set("n", "<leader>s", MiniFiles.open)

-- Debugger
vim.keymap.set("n", "<F1>", dap.continue)
vim.keymap.set("n", "<F2>", dap.step_out)
vim.keymap.set("n", "<F3>", dap.step_over)
vim.keymap.set("n", "<F4>", dap.step_into)
vim.keymap.set("n", "<F5>", function() dap.repl.toggle({ height = 15 }) end)
vim.keymap.set("n", "<leader>n", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader>N", function()
	vim.notify("Reset DAP configuration")
	dapcfg.reset()
end)
vim.keymap.set("n", "<leader>m", scope.toggle)
vim.keymap.set("n", "<leader>M", frame.toggle)

-- Jump
vim.keymap.set("n", "s", jump_word, { desc = "Start jumping", silent = true })
vim.keymap.set({ "x", "o" }, "s", jump_char, { desc = "Start jumping", silent = true })

-- Spelling
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
vim.keymap.set("n", "<leader>z", MiniExtra.pickers.spellsuggest)

-- Git
vim.keymap.set("n", "<leader>hh", MiniDiff.toggle_overlay)
vim.keymap.set("n", "<leader>hk", MiniGit.show_at_cursor)
vim.keymap.set("n", "<leader>hd", function()
	local c1 = vim.fn.input("From Commit: ")
	vim.cmd("Git diff " .. c1 .. "..HEAD")
end)

-- External Programs
vim.keymap.set("n", "<leader>d", function() vim.system({ "st" }, { stdout = false, detach = true }) end,
	{ desc = "Open new terminal in same directory.", silent = true })
vim.keymap.set("n", "<leader>hj",
	function() vim.system({ "st", "-e", "lazygit" }, { stdout = false, detach = true }) end,
	{ desc = "Open new terminal in same directory.", silent = true })

-- LSP
vim.keymap.set('n', 'grd', vim.lsp.buf.definition, { desc = "Goto definition" })
vim.keymap.set('n', '<a-i>', vim.lsp.buf.format, { desc = "Format document" })
vim.keymap.set("n", "gO", function() MiniExtra.pickers.lsp({ scope = "document_symbol" }) end)

--
-- Commands
--

usercmd("Open", function(opts) vim.system({ "xdg-open", opts.args }, { stdout = false, detach = true }) end, -- Open with default app
	{ nargs = 1, complete = "file_in_path", desc = "Open file using xdg-open" })

autocmd("FileType", { -- Quicklist buffers don't appear in bufferlist
	desc = "Unlist quickfist buffers",
	group = augroup("unlist_quickfist", { clear = true }),
	pattern = "qf",
	callback = function() vim.opt_local.buflisted = false end,
})
