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

vim.g.mapleader = " "

vim.g.zig_fmt_parse_errors = 0                                         -- Don't open quickfix on save


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
	function ()
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

vim.keymap.set("n", "<leader>d", function() vim.system({ "st", "-e", "bash" }, { stdout = false, detach = true }) end,
	{ desc = "Open new terminal in same directory.", silent = true })
vim.keymap.set("n", "<leader>h", function() vim.system({ "st", "-e", "lazygit" }, { stdout = false, detach = true }) end,
	{ desc = "Open new terminal in same directory.", silent = true })
vim.api.nvim_create_user_command("Open",
	function(opts) vim.system({ "xdg-open", opts.args }, { stdout = false, detach = true }) end,
	{ nargs = 1, complete = "file_in_path", desc = "Open file using xdg-open" })

vim.keymap.set({ "n", "x" }, "<a-d>", function() vim.diagnostic.jump { count = 1, float = true } end,
	{ desc = "Next Diagnostic" })
vim.keymap.set({ "n", "x" }, "<a-D>", function() vim.diagnostic.jump { count = -1, float = true } end,
	{ desc = "Previous Diagnostic" })

vim.keymap.set("n", "<leader>f", ":Find ", { desc = "Find a file using fd" })
vim.keymap.set("n", "<leader>b", ":b ", { desc = "Find a buffer" })
vim.keymap.set("n", "<leader>g", ":grep ", { desc = "Find a string" })

vim.keymap.set('n', 'grd', vim.lsp.buf.definition, { desc = "Goto definition" })
vim.keymap.set('n', '<a-i>', vim.lsp.buf.format, { desc = "Format document" })

--
-- Autocmds
--

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local usercmd = vim.api.nvim_create_user_command

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

--
-- Custom find using fd
--

usercmd("Find", function(opts)
	vim.cmd("edit " .. opts.args)
end, {
	nargs = 1,
	complete = function(arg_lead, cmd_line, cursor_pos)
		local fd_cmd = 'fd -H -t f -E .git ' .. vim.fn.shellescape(arg_lead)
		return vim.split(vim.fn.system(fd_cmd), '\n', { trimempty = true })
	end
})
