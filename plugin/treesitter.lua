require "nvim-treesitter".setup()

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "cpp", "zig", "rust", "lua", "java", "python" },
	callback = function()
		vim.treesitter.start()
		vim.wo[0][0].foldmethod = 'expr'
		vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

