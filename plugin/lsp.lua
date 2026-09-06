vim.lsp.enable "gopls"
vim.lsp.enable "emmylua_ls"
vim.lsp.enable "texlab"
vim.lsp.enable "clangd"
vim.lsp.enable "zls"
vim.lsp.enable "rust_analyzer"
vim.lsp.enable "arduino_language_server"
vim.lsp.enable "zuban"

vim.keymap.set('n', keymap.LSPDefinition, vim.lsp.buf.definition, { desc = "Goto definition", nowait = true })
vim.keymap.set('n', keymap.LSPFormat, vim.lsp.buf.format, { desc = "Format document", nowait = true })
vim.keymap.set("n", keymap.LSPCodeAction, vim.lsp.buf.code_action, { desc = "Perform a code action", nowait = true })
vim.keymap.set("n", keymap.LSPDeclaration, vim.lsp.buf.declaration, { desc = "Goto declaration", nowait = true })
vim.keymap.set("n", keymap.LSPHover, vim.lsp.buf.hover, { desc = "Show LSP into for word under cursor", nowait = true })
vim.keymap.set("n", keymap.LSPImplementation, vim.lsp.buf.implementation, { desc = "Goto implementation", nowait = true })
vim.keymap.set("n", keymap.LSPRename, vim.lsp.buf.rename, { desc = "Rename a LSP symbol", nowait = true })

vim.keymap.set("n", keymap.LSPReferences, function() MiniExtra.pickers.lsp({ scope = "references" }) end,
	{ desc = "Show all references of a LSP symbol", nowait = true })

vim.keymap.set("n", keymap.LSPSymbolPick, function() MiniExtra.pickers.lsp({ scope = "document_symbol" }) end,
	{ desc = "Pick out a workspace symbol and jump to it" })

vim.keymap.set({ "n", "x" }, keymap.NextDiagnostic, function() vim.diagnostic.jump { count = 1, float = true } end,
	{ desc = "Move to next Diagnostic" })

vim.keymap.set({ "n", "x" }, keymap.PrevDiagnostic, function() vim.diagnostic.jump { count = -1, float = true } end,
	{ desc = "Move to previous Diagnostic" })
