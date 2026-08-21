local tab = require "tab"

vim.t.role = "code" -- Adopt the startup tab, so <m-1> never strands itself on a fresh one

vim.keymap.set({ "n", "i", "t" }, "<m-1>", function() tab.go_tab("code") end)
vim.keymap.set({ "n", "i", "t" }, "<m-2>", function() tab.jump_tab("compile") end)
vim.keymap.set({ "n", "i", "t" }, "<m-3>", function() tab.go_tab("terminal", "") end)
vim.keymap.set({ "n", "i", "t" }, "<m-4>", function() tab.go_tab("lazygit", "lazygit") end)
vim.keymap.set({ "n", "i", "t" }, "<m-5>", function() tab.jump_tab("git") end)
vim.keymap.set({ "n", "i", "t" }, "<m-6>", function() tab.go_tab("claude", "claude") end)

vim.api.nvim_create_autocmd("TermOpen", {
	callback = function(ev)
		local opts = { buffer = ev.buf }

		vim.keymap.set("t", keymap.TermNormal, "<c-\\><c-n>", opts)

		for key, dir in pairs {
			[keymap.TermJumpUpWindow] = "k",
			[keymap.TermJumpDownWindow] = "j",
			[keymap.TermJumpLeftWindow] = "h",
			[keymap.TermJumpRightWindow] = "l",
		} do
			vim.keymap.set("t", key, "<c-\\><c-n><cmd>wincmd " .. dir .. "<cr>", opts)
		end
	end
})
