use { -- Colorscheme
	'Shatur/neovim-ayu',
	post_update = function(dir)
		require('ayu').setup {}
		vim.cmd [[colorscheme ayu]]
	end
}

use { 'nvim-lua/plenary.nvim' } -- Library for plugins

use { 'famiu/bufdelete.nvim' }  -- Provides way to delete buffer without messing up window layout

use {                           -- Show window with all matching keys
	'folke/which-key.nvim',
	post_update = function(dir)
		require("which-key").setup {
			disable = { filetypes = { "TelescopePrompt" } },
		}
	end
}

use { -- Close tag for html automatically (treesitter)
	'windwp/nvim-ts-autotag',
}

use { -- Synthax detector
	'nvim-treesitter/nvim-treesitter',
	post_update = function(dir)
		require('nvim-treesitter.configs').setup {
			autotag = {
				enable = true,
			},
			highlight = {
				enable = true,
			}
		}
	end
}

use { -- Telescope file browser
	'nvim-telescope/telescope-file-browser.nvim'
}

use { -- Provides a nice symbol overview
	'stevearc/aerial.nvim',
	post_update = function(dir)
		require('aerial').setup()
	end
}

use { -- Telescope
	'nvim-telescope/telescope.nvim',
	post_update = function(dir)
		require('telescope').setup {
			extensions = {
				file_browser = {
					hijack_netrw = true,
				}
			}
		}

		require('telescope').load_extension('file_browser')
		require('telescope').load_extension('aerial')
	end
}

use { -- Automatically place pairs
	'windwp/nvim-autopairs',
	post_update = function(dir)
		require("nvim-autopairs").setup {
			check_ts = true,
			ts_config = { java = false },
		}
	end
}

use { -- Commenter
	'numToStr/Comment.nvim',
	post_update = function(dir)
		require('Comment').setup()
	end
}

use { -- Nice Icons
	'nvim-tree/nvim-web-devicons',
	post_update = function(dir)
		require('nvim-web-devicons').setup()
	end
}

use { -- Overwrite select prompt to use telescope
	'stevearc/dressing.nvim',
	post_update = function(dir)
		require('dressing').setup {
			input = {
				enabled = false,
			},
			select = {
				backend = { 'telescope', 'builtin' }
			},
		}
	end
}

use { -- Enables color hightlights for hex colorcodes
	'NvChad/nvim-colorizer.lua',
	post_update = function(dir)
		require('colorizer').setup()
	end
}

use { -- Provides some snippets for LuaSnip
	'rafamadriz/friendly-snippets',
}

use { -- Provides a snippet functionality
	'L3MON4D3/LuaSnip',
	post_update = function(dir)
		require('luasnip.loaders.from_vscode').lazy_load()
		require('luasnip.loaders.from_snipmate').lazy_load()
		require('luasnip.loaders.from_lua').lazy_load()
	end
}

use { -- Provides completion
	'hrsh7th/nvim-cmp',
	post_update = function(dir)
		local cmp = require('cmp')
		cmp.setup {
			snippet = {
				expand = function(args)
					require('luasnip').lsp_expand(args.body)
				end,
			},
			window = {
				-- completion = cmp.config.window.bordered(),
				-- documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				['<C-k>'] = cmp.mapping.scroll_docs(-4),
				['<C-j>'] = cmp.mapping.scroll_docs(4),
				['<C-Space>'] = cmp.mapping.complete(),
				['<CR>'] = cmp.mapping.confirm {
					select = true,
				},
				['<Tab>'] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					else
						fallback()
					end
				end, { 'i', 's' }),
				['<S-Tab>'] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					else
						fallback()
					end
				end, { 'i', 's' }),
			}),
			sources = cmp.config.sources({
				{ name = 'nvim_lsp' },
				{ name = 'nvim_lsp_signature_help' },
				{ name = 'luasnip' },
				{ name = 'path' },
				{ name = 'buffer' },
			}, { name = 'buffer' }),
		}
	end
}

use { -- JSON completion schemes (for configs)
	'b0o/SchemaStore.nvim',
}

use { -- LSP injector
	'jose-elias-alvarez/null-ls.nvim',
	post_update = function(dir)
		local null_ls = require('null-ls')
		null_ls.setup {
			sources = {
				null_ls.builtins.formatting.yapf
			}
		}
	end
}

use { -- Adds ability to add lsps, daps, usw.
	'williamboman/mason.nvim',
	post_update = function(dir)
		require('mason').setup()
	end
}

use { -- Provides lspconfig integration with mason
	'williamboman/mason-lspconfig.nvim',
	post_update = function(dir)
		require('mason-lspconfig').setup()
	end
}

-- use { -- Provides Null-ls integration with mason
-- 	'jay-babu/mason-null-ls.nvim',
-- 	post_update = function(dir)
-- 		require('mason-null-ls').setup {
-- 			automatic_setup = true,
-- 		}
-- 	end
-- }

use { -- Provides LSP capabilities
	'hrsh7th/cmp-nvim-lsp',
}

use { -- LSP
	'neovim/nvim-lspconfig',
	post_update = require 'lsp'
}

use { -- Bufferline
	'akinsho/bufferline.nvim',
	post_update = function(dir)
		require('bufferline').setup {
			options = {
				show_buffer_close_icons = false,
				show_close_icon = false,
			}
		}
	end
}

use { -- Statusline
	'nvim-lualine/lualine.nvim',
	post_update = function(dir)
		require('lualine').setup {
			options = {
				icons_enabled = false,
				theme = 'ayu',
				component_separators = '|',
				section_separators = '',
			},
		}
	end
}

use { -- Java LSP
	'mfussenegger/nvim-jdtls',
}

use { -- Scala LSP
	'scalameta/nvim-metals',
}
