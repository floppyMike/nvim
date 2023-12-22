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

-- Copying
maps.v["<c-c>"] = { '"+y', desc = "Copy selected to clipboard." }

-- Searching
maps.n["<leader>f"] = { "<cmd>enew | r !fd -t f<cr><cmd>setlocal buftype=nowrite | setlocal bufhidden=delete<cr>", desc = "Find files" }
maps.n["<leader>n"] = { "<cmd>Lexplore<cr>", desc = "Netrw file browser" }
maps.n["<leader>b"] = {
	function()
		local results = {}

		for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
			if vim.api.nvim_buf_is_loaded(buffer) then
				table.insert(results, vim.api.nvim_buf_get_name(buffer))
			end
		end

		vim.ui.select(results, { prompt = "Find buffer:" }, function(selected)
			if selected then
				vim.api.nvim_command("b " .. selected)
			end
		end)
	end, desc = "Search buffers" }

maps.n["<leader>l"] = { function() require("telescope.builtin").lsp_document_symbols() end, desc = "Search symbols" }

-- Terminal
maps.n["<leader>g"] = { "<cmd>terminal lazygit<cr>", desc = "Terminal lazygit" }
maps.n["<leader>t"] = { "<cmd>terminal<cr>", desc = "Open a terminal" }

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
