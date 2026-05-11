vim.keymap.set('n', keymap.DuckCreate, function() require("duck").hatch("ඞ") end, { desc = "Spawn a pet amogus" })
vim.keymap.set('n', keymap.DuckDestroy, function() require("duck").cook() end, { desc = "Kill a pet amogus" })
vim.keymap.set('n', keymap.DuckDestroyAll, function() require("duck").cook_all() end, { desc = "Kill all pet amogus" })
