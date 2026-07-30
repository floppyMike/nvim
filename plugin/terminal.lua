local tab = require "tab"

vim.t.role = "code" -- Adopt the startup tab, so <m-1> never strands itself on a fresh one

vim.keymap.set({ "n", "i", "t" }, "<m-1>", function() tab.go_tab("code") end)
vim.keymap.set({ "n", "i", "t" }, "<m-2>", function() tab.jump_tab("compile") end)
vim.keymap.set({ "n", "i", "t" }, "<m-3>", function() tab.go_tab("terminal", "") end)
vim.keymap.set({ "n", "i", "t" }, "<m-4>", function() tab.go_tab("lazygit", "lazygit") end)
vim.keymap.set({ "n", "i", "t" }, "<m-5>", function() tab.jump_tab("git") end)
vim.keymap.set({ "n", "i", "t" }, "<m-6>", function() tab.go_tab("pi", "pi") end)
