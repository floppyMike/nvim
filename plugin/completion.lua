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

		vim.keymap.set({ "n", "x" }, "<a-d>", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
		vim.keymap.set({ "n", "x" }, "<a-D>", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })

		local on_attach = function(_, bufnr)
			local opts = { silent = true, buffer = bufnr }

			opts.desc = "Build project"
			vim.keymap.set('n', '<F7>', '<cmd>make<CR>', opts)

			opts.desc = "Rename LSP symbol"
			vim.keymap.set("n", "grn", vim.lsp.buf.rename, opts)

			opts.desc = "Perform code action for LSP symbol"
			vim.keymap.set("n", "gra", vim.lsp.buf.code_action, opts)

			opts.desc = "List references for LSP symbol"
			vim.keymap.set("n", "grr", vim.lsp.buf.references, opts)

			opts.desc = "Goto implementation for LSP symbol"
			vim.keymap.set("n", "gri", vim.lsp.buf.implementation, opts)

			opts.desc = "Goto definition for LSP symbol"
			vim.keymap.set("n", "grd", vim.lsp.buf.definition, opts)

			opts.desc = "List lsp document symbols"
			vim.keymap.set("n", "gO", function() MiniExtra.pickers.lsp({ scope = "document_symbol" }) end, opts)

			opts.desc = "Format document"
			vim.keymap.set('n', '<a-i>', vim.lsp.buf.format, opts)
		end

		-- Lua for neovim
		lsp.lua_ls.setup { -- Neovim complemetion
			capabilities = capabilities,
			on_attach = function(_, bufnr)
				on_attach(_, bufnr)
				vim.keymap.set('n', '<a-i>', vim.lsp.buf.format,
					{ silent = true, buffer = bufnr, desc = "Format document" })
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
				on_attach(_, bufnr)
				vim.keymap.set('n', '<a-i>', "<cmd>%!alejandra -qq<cr>",
					{ silent = true, buffer = bufnr, desc = "Format document" })
			end
		}

		-- Latex
		lsp.texlab.setup {
			capabilities = capabilities,
			on_attach = function(_, bufnr)
				on_attach(_, bufnr)

				local opts = { silent = true, buffer = bufnr }

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
				on_attach(_, bufnr)

				local opts = { silent = true, buffer = bufnr }

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
				on_attach(_, bufnr)

				local opts = { silent = true, buffer = bufnr }

				vim.keymap.set('n', '<F9>', '<cmd>!python %<CR>', { buffer = bufnr, desc = "Run python file" })

				opts.desc = "Format document"
				vim.keymap.set('n', '<a-i>', "<cmd>%!black -q -<cr>", opts)
			end
		}

		-- Zig
		lsp.zls.setup {
			capabilities = capabilities,
			on_attach = function(_, bufnr)
				on_attach(_, bufnr)

				local opts = { silent = true, buffer = bufnr }
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
				on_attach(_, bufnr)

				local opts = { silent = true, buffer = bufnr }

				opts.desc = "Build project"
				vim.keymap.set('n', '<F7>', function()
					vim.o.makeprg = "cargo $*"
					vim.cmd { cmd = "make" }
				end, opts)

				opts.desc = "Format document"
				vim.keymap.set('n', '<a-i>', vim.lsp.buf.format, opts)
			end
		}

		-- Spell Checking
		lsp.ltex_plus.setup {
			capabilities = capabilities,
			on_attach = function(_, bufnr)
				vim.keymap.set("n", "<leader>Z", function()
					local clients = vim.lsp.get_clients({ buffer = bufnr })
					for _, client in ipairs(clients) do
						if client.name == "ltex_plus" then
							vim.ui.input({ prompt = "Enter new language: " }, function(lang)
								client.config.settings.ltex.language = lang
								vim.lsp.buf_notify(bufnr, "workspace/didChangeConfiguration",
									{ settings = client.config.settings })
							end)
							return
						end
					end
				end, { desc = "Enable spell checking" })
			end,
			filetypes = { "tex", "markdown" },
			settings = { ltex = { enabled = { "tex", "markdown" } } },
		}
	end)
end)
