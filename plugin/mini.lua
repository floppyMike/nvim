require"pluginmanager".ensure("echasnovski", "mini.nvim", {})

--
-- Looks
--

require"mini.icons".setup()

--
-- Git tools
--

require"mini.git".setup()
require"mini.diff".setup {
	view = {
		style = "sign",
		signs = { add = '+', change = '~', delete = '-' }
	},
	mappings = {
		goto_first = '',
		goto_prev = '<a-H>',
		goto_next = '<a-h>',
		goto_last = '',
	}
}
vim.keymap.set("n", "<leader>v", MiniDiff.toggle_overlay)

--
-- Pickers
--

require"mini.extra".setup()
require"mini.pick".setup {
	options = { content_from_bottom = true }
}
vim.keymap.set("n", "<leader>f", MiniPick.builtin.files)
vim.keymap.set("n", "<leader>g", MiniPick.builtin.grep)
vim.keymap.set("n", "<leader>b", MiniPick.builtin.buffers)

--
-- Filesystem
--

require"mini.files".setup()
vim.keymap.set("n", "<leader>s", MiniFiles.open)

--
-- Editor
--

require"mini.hipatterns".setup {
	highlighters = {
		todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
		hex_color = require('mini.hipatterns').gen_highlighter.hex_color(),
	}
}

require"mini.pairs".setup()

--
-- Looks
--

require"mini.statusline".setup()
require"mini.tabline".setup()
