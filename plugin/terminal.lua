local go_tab = require "tab".go_tab

vim.keymap.set({ "n", "i", "t" }, "<m-1>", function() go_tab("code") end)
vim.keymap.set({ "n", "i", "t" }, "<m-2>", function() go_tab("compile") end)
vim.keymap.set({ "n", "i", "t" }, "<m-3>", function() go_tab("terminal", "term", true) end)
vim.keymap.set({ "n", "i", "t" }, "<m-4>", function() go_tab("lazygit", "lazygit") end)
