require "pluginmanager".ensure("nvim-treesitter", "nvim-treesitter", {}, function()
	require "pluginmanager".ensure("nvim-treesitter", "nvim-treesitter-textobjects", {}, function()
		require 'nvim-treesitter.configs'.setup {
			highlight = { -- Syntax Highlighting
				enable = true
			},
			indent = { -- Using = we can indent
				enable = true
			},
			textobjects = {
				swap = {
					enable = true,
					swap_next = {
						["<a-l>"] = "@parameter.inner",
						["<a-k>"] = "@function.outer",
						["<a-j>"] = "@attribute.inner",
					},
					swap_previous = {
						["<a-L>"] = "@parameter.inner",
						["<a-K>"] = "@function.outer",
						["<a-J>"] = "@attribute.inner",
					},
				}
			},
		}
	end)
end)
