--
-- Libraries
--

use {
	'nvim-lua/plenary.nvim',
}

--
-- Looks
--

use { -- Colorscheme
	'Shatur/neovim-ayu',
	post_update = function(dir)
		require'ayu'.setup {
			overrides = {
				LineNrAbove = { fg = '#51B3EC' },
				LineNrBelow = { fg = '#FB508F' },
			},
		}
		vim.cmd [[colorscheme ayu]]
	end
}

--
-- Movement
--

use { -- Provides leap navigation
	'ggandor/leap.nvim',
	post_update = function(dir)
		require'leap'.add_default_mappings()
	end
}

--
-- Completion
--

use { -- Provides some snippets for LuaSnip
	'rafamadriz/friendly-snippets',
}
use { -- Provides luasnip <-> cmp integration
	'saadparwaiz1/cmp_luasnip',
}
use { -- Provides a snippet functionality
	'L3MON4D3/LuaSnip',
	post_update = function(dir)
		require'luasnip.loaders.from_vscode'.lazy_load()
	end
}

use { -- Provides buffer completion
	'hrsh7th/cmp-buffer'
}
use { -- Provides path completion
	'hrsh7th/cmp-path'
}
use { -- Provides lsp <-> cmp integration
	'hrsh7th/cmp-nvim-lsp'
}
use { -- Provides signature completion
	'hrsh7th/cmp-nvim-lsp-signature-help'
}
use { -- Provides completion
	'hrsh7th/nvim-cmp',
	post_update = function(dir)
		local cmp = require'cmp'
		cmp.setup {
			completion = {
				completeopt = "menuone,noselect,preview,noinsert",
			},
			snippet = {
				expand = function(args)
					require'luasnip'.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				['<C-k>'] = cmp.mapping.scroll_docs(-4),
				['<C-j>'] = cmp.mapping.scroll_docs(4),
				['<C-Space>'] = cmp.mapping.complete(),
				['<CR>'] = cmp.mapping.confirm { select = true },
				['<C-c>'] = cmp.mapping.confirm { select = true },
				['<Tab>'] = cmp.mapping.select_next_item(),
				['<S-Tab>'] = cmp.mapping.select_prev_item(),
			}),
			sources = cmp.config.sources({
				{ name = 'nvim_lsp' },
				{ name = 'nvim_lsp_signature_help' },
				{ name = 'luasnip' },
				{ name = 'path' },
				{ name = 'buffer' },
			}),
		}
	end
}

--
-- Language Servers
--

use { -- LSP
	'neovim/nvim-lspconfig',
	post_update = function(dir)
		local opts = { noremap = true, silent = true }

		opts.desc = "Goto previous error/warning"
		vim.keymap.set('n', 'g[', vim.diagnostic.goto_prev, opts)

		opts.desc = "Goto next error/warning"
		vim.keymap.set('n', 'g]', vim.diagnostic.goto_next, opts)

		on_attach = function(_, bufnr)
			opts = { noremap = true, silent = true, buffer = bufnr }

			opts.desc = "Show hover code information"
			vim.keymap.set('n', 'gh', vim.lsp.buf.hover, opts)

			opts.desc = "Select code action"
			vim.keymap.set('n', 'gH', vim.lsp.buf.code_action, opts)

			opts.desc = "Goto definition"
			vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)

			opts.desc = "Goto implementation"
			vim.keymap.set('n', 'gD', vim.lsp.buf.implementation, opts)

			opts.desc = "Rename code symbol"
			vim.keymap.set('n', 'gr', vim.lsp.buf.rename, opts)

			opts.desc = "Show code references"
			vim.keymap.set('n', 'gR', vim.lsp.buf.references, opts)

			opts.desc = "Format document"
			vim.keymap.set('n', '<a-i>', vim.lsp.buf.format, opts)

			opts.desc = "Show signature help"
			vim.keymap.set('i', '<c-k>', vim.lsp.buf.signature_help, opts)

			opts.desc = "Search symbols"
			vim.keymap.set("n", "<leader>l", require"telescope.builtin".lsp_document_symbols, opts)
		end

		local capabilities = require'cmp_nvim_lsp'.default_capabilities()
		local lsp = require"lspconfig"

		lsp.rust_analyzer.setup {
			on_attach = function(_, b)
				on_attach(_, b)

				opts.desc = "Test project"
				vim.keymap.set('n', '<F5>', '<cmd>!RUST_BACKTRACE=1 cargo test -- nocapture<CR>', opts)

				opts.desc = "Run project"
				vim.keymap.set('n', '<F6>', '<cmd>!cargo run<CR>')

				opts.desc = "Build project"
				vim.keymap.set('n', '<F7>', '<cmd>!cargo build<CR>')

				opts.desc = "Trace run project"
				vim.keymap.set('n', '<F8>', '<cmd>!RUST_LOG=trace cargo run<CR>')

				opts.desc = "Build release"
				vim.keymap.set('n', '<F9>', '<cmd>!cargo build --release<CR>')

				opts.desc = "Reload cargo"
				vim.keymap.set('n', '<leader>r', '<cmd>CargoReload<CR>')
			end,
			capabilities = capabilities,
		}

		lsp.zls.setup {
			on_attach = function(_, b)
				on_attach(_, b)

				opts.desc = "Test project"
				vim.keymap.set('n', '<F5>', '<cmd>!zig build test<CR>', opts)

				opts.desc = "Build project"
				vim.keymap.set('n', '<F6>', '<cmd>!zig build run<CR>', opts)

				opts.desc = "Build project"
				vim.keymap.set('n', '<F7>', '<cmd>!zig build<CR>', opts)
			end,
			capabilities = capabilities,
		}
	end
}

use { -- Java LSP (uses ftplugin)
	'mfussenegger/nvim-jdtls',
}

--
-- Indentation
--

use { -- Auto indentation
	'Darazaki/indent-o-matic',
	post_update = function(dir)
		require'indent-o-matic'.setup {}
	end
}

--
-- Treesitter
--

use { -- Synthax detector & objects
	'nvim-treesitter/nvim-treesitter',
	post_update = function(dir)
		require'nvim-treesitter.configs'.setup {
			highlight = {
				enable = true
			},
		}
	end
}

--
-- Statusline
--

use { -- Statusline
	'nvim-lualine/lualine.nvim',
	post_update = function(dir)
		require'lualine'.setup {
			options = {
				icons_enabled = false,
				theme = 'ayu',
				component_separators = '|',
				section_separators = '',
			},
			sections = {
				lualine_a = { "buffers" },
				lualine_c = {},
			},
		}
	end
}

--
-- Git
--

use { -- Git gutter
	"lewis6991/gitsigns.nvim",
	post_update = function(dir)
		require'gitsigns'.setup {
			_signs_staged_enable = true
		}
	end
}

--
-- Searching
--

use { -- Telescope
	'nvim-telescope/telescope.nvim',
	post_update = function(dir)
		require'telescope'.setup {}
	end
}
