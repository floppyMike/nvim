--
-- Completion
--

require "pluginmanager".ensure("Saghen", "blink.cmp", {})

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

require "pluginmanager".ensure("neovim", "nvim-lspconfig", {})

local capabilities = require "blink.cmp".get_lsp_capabilities()
local lsp = require "lspconfig"

vim.keymap.set({ "n", "x" }, "<a-d>", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
vim.keymap.set({ "n", "x" }, "<a-D>", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })

local on_attach = function(_, bufnr)
	local opts = { silent = true, buffer = bufnr }

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
	on_attach = on_attach,
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
	on_attach = on_attach
}

-- Latex
lsp.texlab.setup {
	capabilities = capabilities,
	on_attach = on_attach
}
