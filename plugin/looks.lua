vim.cmd.colorscheme "ice"

require "mini.icons".setup()      -- Add nice icons
require "mini.notify".setup()     -- Top right notifications
require "mini.statusline".setup() -- Setup minimal but complete statusline

require "mini.hipatterns".setup { -- Add TODO and hex colors
	highlighters = {
		todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
		hex_color = require('mini.hipatterns').gen_highlighter.hex_color(),
	}
}

vim.api.nvim_create_autocmd("TextYankPost", { -- Highlight on yank
	desc = "Highlight yanked text",
	group = vim.api.nvim_create_augroup("highlightyank", { clear = true }),
	pattern = "*",
	callback = function() vim.highlight.on_yank() end,
})
