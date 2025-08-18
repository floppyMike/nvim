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
		local lsp = require "lspconfig"

		-- Lua for neovim
		lsp.lua_ls.setup { -- Neovim complemetion
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
		lsp.nixd.setup {}

		-- Latex
		lsp.texlab.setup {
			on_attach = function(_, bufnr)
				local opts = { silent = true, buffer = bufnr }

				opts.desc = "Build project"
				vim.keymap.set('n', '<F7>', function()
					vim.o.makeprg = "latexmk -pdf -output-directory=build %"
					vim.cmd("make!")
				end, opts)
			end,
		}

		-- C++
		lsp.clangd.setup {
			cmd = { "clangd", "--background-index", "--clang-tidy", "--query-driver=" .. vim.env.HOME .. "/.local/bin/xpack-arm-none-eabi-gcc-14.2.1-1.1/bin/arm-none-eabi-gcc" },
			on_attach = function(_, bufnr)
				local opts = { silent = true, buffer = bufnr }

				opts.desc = "Build project"
				vim.keymap.set('n', '<F7>', function()
					vim.o.makeprg = "cmake --build build/ --parallel"
					vim.cmd("make!")
				end, opts)
			end,
		}

		-- Python
		lsp.pylsp.setup {
			on_attach = function(_, bufnr)
				vim.keymap.set('n', '<F9>', '<cmd>!python %<CR>', { buffer = bufnr, desc = "Run python file" })
			end
		}

		-- Zig
		lsp.zls.setup {
			on_attach = function(_, bufnr)
				local opts = { silent = true, buffer = bufnr }

				opts.desc = "Build project"
				vim.keymap.set('n', '<F7>', function()
					vim.o.makeprg = "zig build $*"
					vim.cmd("make!")
				end, opts)

				opts.desc = "Test project"
				vim.keymap.set('n', '<F8>', function()
					vim.o.makeprg = "zig build test $*"
					vim.cmd("make!")
				end, opts)
			end
		}

		-- Rust
		lsp.rust_analyzer.setup {
			on_attach = function(_, bufnr)
				local opts = { silent = true, buffer = bufnr }

				opts.desc = "Build project"
				vim.keymap.set('n', '<F7>', function()
					vim.o.makeprg = "cargo $*"
					vim.cmd("make!")
				end, opts)
			end
		}
	end)
end)
