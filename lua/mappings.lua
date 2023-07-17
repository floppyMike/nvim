local maps = { i = {}, n = {}, v = {}, t = {} }

-- Normal --
-- Standard Operations
maps.n["j"] = { "'gj'", expr = true, desc = "Move cursor down" }
maps.n["k"] = { "'gk'", expr = true, desc = "Move cursor up" }
maps.n["|"] = { "<cmd>vsplit<cr>", desc = "Vertical Split" }
maps.n["\\"] = { "<cmd>split<cr>", desc = "Horizontal Split" }

-- Manage Buffers
maps.n["<a-h>"] = { "<cmd>bp<cr>", desc = "Move to left buffer or loop" }
maps.n["<a-l>"] = { "<cmd>bn<cr>", desc = "Move to right buffer or loop" }
maps.n["<F3>"] = { "<cmd>Bdelete<cr>", desc = "Close open buffer" }
maps.n["<leader>v"] = { "<cmd>e $MYVIMRC<cr>", desc = "Open init.lua" }

-- Navigate tabs
maps.n["]t"] = { function() vim.cmd.tabnext() end, desc = "Next tab" }
maps.n["[t"] = { function() vim.cmd.tabprevious() end, desc = "Previous tab" }

-- Splits
maps.n["<C-k>"] = { "<cmd>wincmd k<cr>", desc = "Move to top split" }
maps.n["<C-j>"] = { "<cmd>wincmd j<cr>", desc = "Move to bottom split" }
maps.n["<C-h>"] = { "<cmd>wincmd h<cr>", desc = "Move to left split" }
maps.n["<C-l>"] = { "<cmd>wincmd l<cr>", desc = "Move to right split" }
maps.n["<C-Up>"] = { "<cmd>resize -2<CR>", desc = "Resize split up" }
maps.n["<C-Down>"] = { "<cmd>resize +2<CR>", desc = "Resize split down" }
maps.n["<C-Left>"] = { "<cmd>vertical resize -2<CR>", desc = "Resize split left" }
maps.n["<C-Right>"] = { "<cmd>vertical resize +2<CR>", desc = "Resize split right" }

-- Copying
maps.v["<c-c>"] = { '"+y', desc = "Copy selected to clipboard." }

-- Telescope (Searching)
maps.n["<leader>ff"] = { function() require("telescope.builtin").find_files() end, desc = "Find files" }
maps.n["<leader>fF"] = {
	function() require("telescope.builtin").find_files { hidden = true, no_ignore = true } end,
	desc = "Find all files",
}
maps.n["<leader>fw"] = { function() require("telescope.builtin").live_grep() end, desc = "Find words" }
maps.n["<leader>fW"] = {
	function()
		require("telescope.builtin").live_grep {
			additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore" }) end,
		}
	end,
	desc = "Find words in all files",
}
maps.n["<leader>fb"] = {
	function() require("nnn").toggle("picker") end,
	desc = "nnn file browser"
}
maps.n["<leader>l"] = { function() require("telescope.builtin").lsp_document_symbols() end, desc = "Search symbols" }

-- Terminal
if vim.fn.executable "lazygit" == 1 then
	maps.n["<leader>g"] = { "<cmd>terminal lazygit<cr>", desc = "Terminal lazygit" }
end
if vim.fn.executable "node" == 1 then
	maps.n["<leader>n"] = { "<cmd>terminal node<cr>", desc = "Terminal node" }
end
if vim.fn.executable "gdu" == 1 then
	maps.n["<leader>u"] = { "<cmd>terminal gdu<cr>", desc = "Terminal gdu" }
end
if vim.fn.executable "btm" == 1 then
	maps.n["<leader>b"] = { "<cmd>terminal btm<cr>", desc = "Terminal btm" }
end
if vim.fn.executable "python" == 1 then
	maps.n["<leader>p"] = { "<cmd>terminal python<cr>", desc = "Terminal python" }
end
maps.n["<leader>t"] = { "<cmd>terminal<cr>", desc = "Open a terminal" }

-- modified function keys found with `showkey -a` in the terminal to get key code
-- run `nvim -V3log +quit` and search through the "Terminal info" in the `log` file for the correct keyname
-- maps.n["<F5>"] = { function() require("dap").continue() end, desc = "Debugger: Start" }
-- maps.n["<F17>"] = { function() require("dap").terminate() end, desc = "Debugger: Stop" }         -- Shift+F5
-- maps.n["<F29>"] = { function() require("dap").restart_frame() end, desc = "Debugger: Restart" }  -- Control+F5
-- maps.n["<F6>"] = { function() require("dap").pause() end, desc = "Debugger: Pause" }
-- maps.n["<F9>"] = { function() require("dap").toggle_breakpoint() end, desc = "Debugger: Toggle Breakpoint" }
-- maps.n["<F10>"] = { function() require("dap").step_over() end, desc = "Debugger: Step Over" }
-- maps.n["<F11>"] = { function() require("dap").step_into() end, desc = "Debugger: Step Into" }
-- maps.n["<F23>"] = { function() require("dap").step_out() end, desc = "Debugger: Step Out" }  -- Shift+F11
-- maps.n["<leader>db"] = { function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint (F9)" }
-- maps.n["<leader>dB"] = { function() require("dap").clear_breakpoints() end, desc = "Clear Breakpoints" }
-- maps.n["<leader>dc"] = { function() require("dap").continue() end, desc = "Start/Continue (F5)" }
-- maps.n["<leader>di"] = { function() require("dap").step_into() end, desc = "Step Into (F11)" }
-- maps.n["<leader>do"] = { function() require("dap").step_over() end, desc = "Step Over (F10)" }
-- maps.n["<leader>dO"] = { function() require("dap").step_out() end, desc = "Step Out (S-F11)" }
-- maps.n["<leader>dq"] = { function() require("dap").close() end, desc = "Close Session" }
-- maps.n["<leader>dQ"] = { function() require("dap").terminate() end, desc = "Terminate Session (S-F5)" }
-- maps.n["<leader>dp"] = { function() require("dap").pause() end, desc = "Pause (F6)" }
-- maps.n["<leader>dr"] = { function() require("dap").restart_frame() end, desc = "Restart (C-F5)" }
-- maps.n["<leader>dR"] = { function() require("dap").repl.toggle() end, desc = "Toggle REPL" }
-- maps.n["<leader>du"] = { function() require("dapui").toggle() end, desc = "Toggle Debugger UI" }
-- maps.n["<leader>dh"] = { function() require("dap.ui.widgets").hover() end, desc = "Debugger Hover" }

-- Stay in indent mode
maps.v["<S-Tab>"] = { "<gv", desc = "unindent line" }
maps.v["<Tab>"] = { ">gv", desc = "indent line" }

-- Wrapping
maps.n["<leader>uw"] = { function() vim.wo.wrap = not vim.wo.wrap end, desc = "Toggle wrap" }

-- Stop search on ESC
maps.n["<esc>"] = { "<cmd>noh<CR>", desc = "Stop search with ESC" }

-- Spelling
maps.n["<leader>z"] = {
	function()
		vim.opt_local.spell = not (vim.opt_local.spell:get())
		print("spell: " .. tostring(vim.opt_local.spell:get()))
	end,
	desc = "Enable spell checking"
}
maps.n["ze"] = {
	function()
		vim.opt.spelllang = { 'en' }
		print("lang: english")
	end,
	desc = "Set spellcheck to english"
}
maps.n["zd"] = {
	function()
		vim.opt.spelllang = { 'de' }
		print("lang: german")
	end,
	desc = "Set spellcheck to german"
}

-- utils.set_mappings(maps)
for mode, body in pairs(maps) do
	-- iterate over each keybinding set in the current mode
	for keymap, options in pairs(body) do
		local cmd = options[1]
		local keymap_opts = vim.tbl_deep_extend("force", {}, options)
		keymap_opts[1] = nil
		vim.keymap.set(mode, keymap, cmd, keymap_opts)
	end
end
