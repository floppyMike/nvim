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
		},
		completion = {
			documentation = { auto_show = true },
		}
	}

	--
	-- LSP
	--
	require "pluginmanager".ensure("neovim", "nvim-lspconfig", {}, function()
		vim.lsp.config("lua_ls", {
			on_init = function(client)
				if client.workspace_folders then
					local path = client.workspace_folders[1].name
					if path ~= vim.fn.stdpath('config') and (vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc')) then
						return
					end
				end
				client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
					runtime = {
						version = 'LuaJIT',
						path = {
							'lua/?.lua',
							'lua/?/init.lua',
						},
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
		})

		vim.lsp.config("texlab", {
			on_attach = function(_, bufnr)
				local opts = { silent = true, buffer = bufnr }

				opts.desc = "Build project"
				vim.keymap.set('n', '<F7>', '<cmd>make<cr>', opts)
			end,
		})

		vim.lsp.config("clangd", {
			cmd = { "clangd", "--background-index", "--clang-tidy" },
			on_attach = function(_, bufnr)
				local opts = { silent = true, buffer = bufnr }

				opts.desc = "Build project"
				vim.keymap.set('n', '<F7>', function()
					vim.o.makeprg = "cmake --build build/ --parallel"
					vim.cmd("make!")
				end, opts)
			end,
		})

		vim.lsp.config("zls", {
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
		})

		vim.lsp.config("rust_analyzer", {
			on_attach = function(_, bufnr)
				local opts = { silent = true, buffer = bufnr }

				opts.desc = "Build project"
				vim.keymap.set('n', '<F7>', "<cmd>make! build<cr>", opts)
			end
		})

		vim.lsp.config("nixd", {
			on_attach = function(_, bufnr)
				vim.keymap.set('n', '<a-i>', "<cmd>%!alejandra -qq<cr>",
					{ silent = true, buffer = bufnr, desc = "Format document" })
			end
		})

		require "pluginmanager".ensure("mason-org", "mason.nvim", {}, function()
			require "mason".setup()

			require "pluginmanager".ensure("mason-org", "mason-lspconfig.nvim", {}, function()
				require "mason-lspconfig".setup()
			end)
		end)
	end)
end)
