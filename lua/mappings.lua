local maps = { i = {}, n = {}, v = {}, t = {} }

-- Standard Operations
maps.n["|"] = { "<cmd>vsplit<cr>", desc = "Vertical Split" }
maps.n["\\"] = { "<cmd>split<cr>", desc = "Horizontal Split" }

-- Splits
maps.n["<C-k>"] = { "<cmd>wincmd k<cr>", desc = "Move to top split" }
maps.n["<C-j>"] = { "<cmd>wincmd j<cr>", desc = "Move to bottom split" }
maps.n["<C-h>"] = { "<cmd>wincmd h<cr>", desc = "Move to left split" }
maps.n["<C-l>"] = { "<cmd>wincmd l<cr>", desc = "Move to right split" }
maps.n["<C-Up>"] = { "<cmd>resize -2<CR>", desc = "Resize split up" }
maps.n["<C-Down>"] = { "<cmd>resize +2<CR>", desc = "Resize split down" }
maps.n["<C-Left>"] = { "<cmd>vertical resize -2<CR>", desc = "Resize split left" }
maps.n["<C-Right>"] = { "<cmd>vertical resize +2<CR>", desc = "Resize split right" }

-- Buffers
maps.n["<a-h>"] = { "<cmd>bp<cr>", desc = "Move to left buffer or loop" }
maps.n["<a-l>"] = { "<cmd>bn<cr>", desc = "Move to right buffer or loop" }
maps.n["<a-d>"] = { "<cmd>Bd<cr>", desc = "Close open buffer" }
maps.n["<bs>"] = { "<c-^>", desc = "Goto alternate buffer" }

-- Copying
maps.v["<c-c>"] = { '"+y', desc = "Copy selected to clipboard." }

-- Searching
maps.n["<leader>f"] = { require'telescope.builtin'.find_files, desc = "Find files" }
maps.n["<leader>b"] = { require'telescope.builtin'.buffers, desc = "Find buffers" }
maps.n["<leader>s"] = { require'telescope.builtin'.live_grep, desc = "Find buffers" }

-- Stay in indent mode
maps.v["<S-Tab>"] = { "<gv", desc = "unindent line" }
maps.v["<Tab>"] = { ">gv", desc = "indent line" }

-- Stop search on ESC
maps.n["<esc>"] = { "<cmd>noh<CR>", desc = "Stop search with ESC" }

-- Git
maps.n["<leader>hs"] = { require"gitsigns".stage_hunk, desc = "Stage hunk normal" }
maps.n["<leader>hS"] = { require"gitsigns".stage_buffer, desc = "Stage buffer" }
maps.v["<leader>hs"] = { function() require"gitsigns".stage_hunk{ vim.fn.line("."), vim.fn.line("v") } end, desc = "Stage hunk" }
maps.n["<leader>hp"] = { require"gitsigns".preview_hunk, desc = "Preview hunk" }
maps.n["<leader>hc"] = {
	function()
		local msg = vim.fn.input("Commit message: ")
		if msg == '' then return end
		vim.cmd(string.format("!git commit -m '%s'", msg))
	end, desc = "Git commit" }

-- Spelling
maps.n["<leader>z"] = { require"telescope.builtin".spell_suggest, desc = "Enable spell checking" }
maps.n["<leader>Z"] = {
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
		options[1] = nil
		vim.keymap.set(mode, keymap, cmd, options)
	end
end
