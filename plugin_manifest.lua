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
	'EdenEast/nightfox.nvim',
	'ellisonleao/gruvbox.nvim',
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

use {
	'rafamadriz/friendly-snippets', -- Provides some snippets for LuaSnip
	'saadparwaiz1/cmp_luasnip', -- Provides luasnip <-> cmp integration
	'L3MON4D3/LuaSnip', -- Provides a snippet functionality
	post_update = function(dir)
		require'luasnip.loaders.from_vscode'.lazy_load({ paths = "~/.config/nvim/snippets" })
		local ls = require'luasnip'

		opts = { noremap = true, silent = true }

		opts.desc = "Goto next snippet item"
		vim.keymap.set('i', '<C-l>', function() ls.jump(1) end, opts)
		opts.desc = "Goto prev snippet item"
		vim.keymap.set('i', '<C-h>', function() ls.jump(-1) end, opts)
	end
}

use {
	'hrsh7th/cmp-buffer', -- Provides buffer completion
	'hrsh7th/cmp-path', -- Provides path completion
	'hrsh7th/cmp-nvim-lsp', -- Provides lsp <-> cmp integration
	'hrsh7th/cmp-nvim-lsp-signature-help', -- Provides signature completion
	'hrsh7th/nvim-cmp', -- Provides completion
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

use {
	'mfussenegger/nvim-dap', -- Debugger
	'neovim/nvim-lspconfig', -- LSP
	'mfussenegger/nvim-jdtls', -- Java LSP
	post_update = function(dir)
		local opts = { noremap = true, silent = true }

		opts.desc = "Goto previous error/warning"
		vim.keymap.set('n', 'g[', vim.diagnostic.goto_prev, opts)

		opts.desc = "Goto next error/warning"
		vim.keymap.set('n', 'g]', vim.diagnostic.goto_next, opts)

		on_attach = function(_, bufnr)
			opts = { noremap = true, silent = true, buffer = bufnr }

			-- Debugging
			dap = require"dap"
			dapwidgets = require"dap.ui.widgets"
			scope = dapwidgets.sidebar(dapwidgets.scopes)
			frame = dapwidgets.sidebar(dapwidgets.frames)

			opts.desc = "DAP continue/start"
			vim.keymap.set('n', '<F9>', dap.continue, opts)

			opts.desc = "DAP step over"
			vim.keymap.set('n', '<F10>', dap.step_over, opts)

			opts.desc = "DAP step into"
			vim.keymap.set('n', '<F11>', dap.step_into, opts)

			opts.desc = "DAP step out"
			vim.keymap.set('n', '<F12>', dap.step_out, opts)

			opts.desc = "DAP toggle breakpoint"
			vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, opts)

			opts.desc = "DAP hover info"
			vim.keymap.set('n', '<Leader>dh', dapwidgets.hover, opts)

			opts.desc = "DAP hover info"
			vim.keymap.set('n', '<Leader>dp', dapwidgets.preview, opts)

			opts.desc = "DAP hover info"
			vim.keymap.set('n', '<Leader>df', frame.toggle, opts)

			opts.desc = "DAP hover info"
			vim.keymap.set('n', '<Leader>ds', scope.toggle, opts)

			-- LSP

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
				vim.keymap.set('n', '<F6>', '<cmd>!cargo run<CR>', opts)

				opts.desc = "Build project"
				vim.keymap.set('n', '<F7>', '<cmd>!cargo build<CR>', opts)

				opts.desc = "Trace run project"
				vim.keymap.set('n', '<F8>', '<cmd>!RUST_LOG=trace cargo run<CR>', opts)

				opts.desc = "Build release"
				vim.keymap.set('n', '<F9>', '<cmd>!cargo build --release<CR>', opts)

				opts.desc = "Reload cargo"
				vim.keymap.set('n', '<leader>r', '<cmd>CargoReload<CR>', opts)
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

		lsp.pylsp.setup {
			on_attach = function(_, b)
				on_attach(_, b)
				vim.keymap.set('n', '<F7>', '<cmd>!python \'' .. vim.api.nvim_buf_get_name(0) .. '\'<CR>')
			end,
			capabilities = capabilities,
		}

		lsp.texlab.setup {
			on_attach = function(_, b)
				on_attach(_, b)
				vim.keymap.set('n', '<F7>', '<cmd>!latexmk -pdf \'' .. vim.api.nvim_buf_get_name(0) .. '\'<CR>')
				vim.keymap.set('n', '<F8>', '<cmd>!zathura \'' .. (vim.api.nvim_buf_get_name(0):gsub("%.tex$", ".pdf")) .. '\' &<CR>')
			end,
			capabilities = capabilities,
		}

		lsp.marksman.setup {
			on_attach = function(_, b)
				on_attach(_, b)
				vim.keymap.set('n', '<F8>', '<cmd>!inlyne \'' .. (vim.api.nvim_buf_get_name(0):gsub("%.tex$", ".pdf")) .. '\' &<CR>')
			end,
			capabilities = capabilities,
		}

		lsp.clangd.setup {
			on_attach = function(_, b)
				on_attach(_, b)
				vim.keymap.set('n', '<F7>', '<cmd>!cmake -S . -B build/ -D CMAKE_EXPORT_COMPILE_COMMANDS=1 && cmake --build build/<CR>')
				vim.keymap.set('n', '<F8>', '<cmd>!cmake -S . -B build/ && cmake --build build/ && ./build/' ..	vim.fn.substitute(vim.fn.getcwd(), '^.*/', '', '') .. '<CR>')
			end,
			capabilities = capabilities,
		}

		lsp.nixd.setup {
			on_attach = function(_, b)
				on_attach(_, b)
				vim.keymap.set('n', '<F7>', '<cmd>!tmux neww -n rebuild -P "tmux setw remain-on-exit on; update-sys"<CR><CR>')
				vim.keymap.set('n', '<F8>', '<cmd>!tmux neww -n rebuild -P "tmux setw remain-on-exit on; update-sys-hard"<CR><CR>')
			end,
			capabilities = capabilities,
		}
	end
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
				component_separators = '|',
				section_separators = '',
			},
			sections = {
				lualine_a = { "buffers" },
				lualine_c = {},
				lualine_z = { "tabs" },
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
	'nvim-telescope/telescope-fzf-native.nvim',
	post_update = function(dir)
		require'telescope'.setup {
			defaults = require'telescope.themes'.get_ivy()
		}
		require'telescope'.load_extension("fzf")
	end
}

--
-- File System
--

use {
	'stevearc/oil.nvim',
	post_update = function(dir)
		require"oil".setup {}
	end
}
