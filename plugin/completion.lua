--
-- Completion
--
require "pluginmanager".ensure("Saghen", "blink.cmp", {}, function()
	require "blink.cmp".setup {
		sources = {
			default = { "lsp", "path", "snippets", "buffer" }
		},
		fuzzy = {
			implementation = "lua"
		},
		signature = {
			enabled = true
		}
	}

	--
	-- LSP
	--
	require "pluginmanager".ensure("neovim", "nvim-lspconfig", {}, function()
		local capabilities = require "blink.cmp".get_lsp_capabilities()
		local lsp = require "lspconfig"

		function on_attach(_, bufnr, opts)
			opts.desc = "Goto definition"
			vim.keymap.set('n', 'grd', vim.lsp.buf.definition, opts)
		end

		-- Lua for neovim
		lsp.lua_ls.setup { -- Neovim complemetion
			capabilities = capabilities,
			on_attach = function(_, bufnr)
				local opts = { silent = true, buffer = bufnr }
				on_attach(_, bufnr, opts)

				opts.desc = "Format document"
				vim.keymap.set('n', '<a-i>', vim.lsp.buf.format, opts)
			end,
			on_init = function(client)
				if client.workspace_folders then
					local path = client.workspace_folders[1].name
					if path ~= vim.fn.stdpath('config') and (vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc')) then
						return
					end
				end
				client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
					runtime = {
						version = 'LuaJIT'
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
		}

		-- Nix for NixOS config
		lsp.nixd.setup {
			capabilities = capabilities,
			on_attach = function(_, bufnr)
				local opts = { silent = true, buffer = bufnr }
				on_attach(_, bufnr, opts)

				opts.desc = "Format document"
				vim.keymap.set('n', '<a-i>', "<cmd>%!alejandra -qq<cr>", opts)
			end
		}

		-- Latex
		lsp.texlab.setup {
			capabilities = capabilities,
			on_attach = function(_, bufnr)
				local opts = { silent = true, buffer = bufnr }
				on_attach(_, bufnr, opts)

				opts.desc = "Format document"
				vim.keymap.set('n', '<a-i>', vim.lsp.buf.format, opts)

				opts.desc = "Build project"
				vim.keymap.set('n', '<F7>', function()
					vim.o.makeprg = "latexmk -pdf -output-directory=build %"
					vim.cmd { cmd = "make" }
				end, opts)
			end,
		}

		-- C++
		lsp.clangd.setup {
			capabilities = capabilities,
			on_attach = function(_, bufnr)
				local opts = { silent = true, buffer = bufnr }
				on_attach(_, bufnr, opts)

				opts.desc = "Format document"
				vim.keymap.set('n', '<a-i>', vim.lsp.buf.format, opts)

				opts.desc = "Build project"
				vim.keymap.set('n', '<F7>', function()
					vim.o.makeprg = "cmake --build build/ --parallel"
					vim.cmd { cmd = "make" }
				end, opts)
			end,
		}

		-- Python
		lsp.pylsp.setup {
			capabilities = capabilities,
			on_attach = function(_, bufnr)
				local opts = { silent = true, buffer = bufnr }
				on_attach(_, bufnr, opts)

				vim.keymap.set('n', '<F9>', '<cmd>!python %<CR>', { buffer = bufnr, desc = "Run python file" })

				opts.desc = "Format document"
				vim.keymap.set('n', '<a-i>', "<cmd>%!black -q -<cr>", opts)
			end
		}

		-- Zig
		lsp.zls.setup {
			capabilities = capabilities,
			on_attach = function(_, bufnr)
				local opts = { silent = true, buffer = bufnr }
				on_attach(_, bufnr, opts)

				vim.g.zig_fmt_parse_errors = 0

				opts.desc = "Format document"
				vim.keymap.set('n', '<a-i>', vim.lsp.buf.format, opts)

				opts.desc = "Build project"
				vim.keymap.set('n', '<F7>', function()
					vim.o.makeprg = "zig build $*"
					vim.cmd { cmd = "make" }
				end, opts)

				opts.desc = "Test project"
				vim.keymap.set('n', '<F8>', function()
					vim.o.makeprg = "zig build test $*"
					vim.cmd { cmd = "make" }
				end, opts)
			end
		}

		-- Rust
		lsp.rust_analyzer.setup {
			capabilities = capabilities,
			on_attach = function(_, bufnr)
				local opts = { silent = true, buffer = bufnr }
				on_attach(_, bufnr, opts)

				opts.desc = "Build project"
				vim.keymap.set('n', '<F7>', function()
					vim.o.makeprg = "cargo $*"
					vim.cmd { cmd = "make" }
				end, opts)

				opts.desc = "Format document"
				vim.keymap.set('n', '<a-i>', vim.lsp.buf.format, opts)
			end
		}
	end)
end)
