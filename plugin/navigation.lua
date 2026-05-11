require "mini.pick".setup {
	options = { content_from_bottom = true },
	source = { choose_marked = function(items) MiniPick.default_choose_marked(items, { list_type = "location" }) end }
}

require "mini.jump".setup {
	mappings = {
		repeated_jump = keymap.JumpRepeat,
	},
}

local Jump2d = require("mini.jump2d")
Jump2d.setup({ mappings = { start_jumping = "" } })

vim.keymap.set("n", keymap.NextBuffer, "<cmd>bn<cr>", { desc = "Move to right buffer or loop" })
vim.keymap.set("n", keymap.PrevBuffer, "<cmd>bp<cr>", { desc = "Move to left buffer or loop" })
vim.keymap.set("n", keymap.NextQuickfix, "<cmd>cnext<cr>", { desc = "Move to next quickfix item" })
vim.keymap.set("n", keymap.PrevQuickfix, "<cmd>cprevious<cr>", { desc = "Move to previous quickfix item" })
vim.keymap.set("n", keymap.NextLocation, "<cmd>lnext<cr>", { desc = "Move to next location list item" })
vim.keymap.set("n", keymap.PrevLocation, "<cmd>lprevious<cr>", { desc = "Move to previous location list item" })
vim.keymap.set({ "n", "v" }, keymap.NextParagraph, "}", { desc = "Move to next paragraph" })
vim.keymap.set({ "n", "v" }, keymap.PrevParagraph, "{", { desc = "Move to previous paragraph" })

vim.keymap.set("n", "<esc>", "<cmd>noh<CR>", { desc = "Stop search with ESC" })

vim.keymap.set("n", keymap.FilePick, MiniPick.builtin.files)
vim.keymap.set("n", keymap.GrepPick, MiniPick.builtin.grep)
vim.keymap.set("n", keymap.BufferPick, MiniPick.builtin.buffers)

for i = 1, 9 do
	vim.keymap.set("n", "<a-" .. i .. ">", i .. "gt", { desc = "Go to tab " .. i })
end

vim.keymap.set("n", keymap.JumpWord, function()
	local builtin = Jump2d.builtin_opts.word_start
	builtin.view = { n_steps_ahead = 10 }
	Jump2d.start(builtin)
end, { desc = "Start jumping", silent = true })

vim.keymap.set({ "x", "o" }, keymap.JumpChar, function()
	local builtin = Jump2d.builtin_opts.single_character
	Jump2d.start(builtin)
end, { desc = "Start jumping", silent = true })

vim.keymap.set("n", keymap.ExitWindow, ":q<cr>", { desc = "Quit window" })
