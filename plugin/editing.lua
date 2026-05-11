require 'indent-o-matic'.setup {}
require "mini.pairs".setup() -- Auto add matching bracket pair
require "mini.trailspace".setup() -- See bad trailing whitespace

require "mini.surround".setup { -- Add surround text with functionality
	mappings = {
		add = keymap.SurroundAdd,
		delete = keymap.SurroundDelete,
		find = keymap.SurroundFindFront,
		find_left = keymap.SurroundFindBack,
		highlight = keymap.SurroundHighlight,
		replace = keymap.SurroundReplace,
	},
}

local ai = require "mini.ai"
ai.setup {
	custom_textobjects = {
		o = ai.gen_spec.treesitter({
			a = { '@block.outer', '@conditional.outer', '@loop.outer' },
			i = { '@block.inner', '@conditional.inner', '@loop.inner' },
		}, {}),
		F = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }, {}),
		c = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }, {}),
		e = {
			{
				"%u[%l%d]+%f[^%l%d]",
				"%f[%S][%l%d]+%f[^%l%d]",
				"%f[%P][%l%d]+%f[^%l%d]",
				"^[%l%d]+%f[^%l%d]",
				"%f[%S][%w]+%f[^%w]",
				"%f[%P][%w]+%f[^%w]",
				"^%w+%f[^%w]",
			},
			"^().*()$",
		},
	},
}

require "mini.move".setup {
	mappings = {
		left = keymap.MoveLeft,
		right = keymap.MoveRight,
		down = keymap.MoveDown,
		up = keymap.MoveUp,
		line_left = keymap.MoveLineLeft,
		line_right = keymap.MoveLineRight,
		line_down = keymap.MoveLineDown,
		line_up = keymap.MoveLineUp,
	},
}

vim.keymap.set("n", keymap.TrailRemove, MiniTrailspace.trim, { desc = "Remove trailing whitespace on line" })
vim.keymap.set("n", keymap.TrailRemoveAll, MiniTrailspace.trim_last_lines, { desc = "Remove all trailing whitespace" })

