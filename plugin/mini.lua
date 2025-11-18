require "pluginmanager".ensure("echasnovski", "mini.nvim", {}, function()
	--
	-- Looks
	--

	require "mini.icons".setup()

	--
	-- Git tools
	--

	require "mini.git".setup()
	require "mini.diff".setup {
		view = {
			style = "sign",
			signs = { add = '+', change = '~', delete = '-' }
		},
		mappings = {
			apply = '<leader>ha';
			reset = '<leader>hr';
			goto_first = '',
			goto_prev = '<a-H>',
			goto_next = '<a-h>',
			goto_last = '',
		},
		options = {
			wrap_goto = true,
		},
	}

	vim.keymap.set("n", "<leader>hh", MiniDiff.toggle_overlay)
	vim.keymap.set("n", "<leader>hk", MiniGit.show_at_cursor)
	vim.keymap.set("n", "<leader>hs", "<cmd>Git status<cr>")
	vim.keymap.set("n", "<leader>hd", "<cmd>Git diff<cr>")
	vim.keymap.set("n", "<leader>hl", "<cmd>Git log --stat --find-renames -10<cr>")

	--
	-- Pickers
	--

	require "mini.extra".setup()
	require "mini.pick".setup {
		options = { content_from_bottom = true },
		source = { choose_marked = function (items) MiniPick.default_choose_marked(items, { "location" }) end }
	}
	vim.keymap.set("n", "<leader>f", MiniPick.builtin.files)
	vim.keymap.set("n", "<leader>g", MiniPick.builtin.grep)
	vim.keymap.set("n", "<leader>b", MiniPick.builtin.buffers)
	vim.keymap.set("n", "<leader>z", MiniExtra.pickers.spellsuggest)
	vim.keymap.set("n", "gO", function() MiniExtra.pickers.lsp({ scope = "document_symbol" }) end)

	--
	-- Filesystem
	--

	require "mini.files".setup()
	vim.keymap.set("n", "<leader>s", MiniFiles.open)

	--
	-- Editor
	--

	require "mini.hipatterns".setup {
		highlighters = {
			todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
			hex_color = require('mini.hipatterns').gen_highlighter.hex_color(),
		}
	}

	require "pluginmanager".ensure("nvim-treesitter", "nvim-treesitter-textobjects", {}, function()
		local ai = require "mini.ai"
		ai.setup {
			mappings = {
				goto_left = '<a-G>',
				goto_right = '<a-g>',
			},
			custom_textobjects = {
				o = ai.gen_spec.treesitter({
					a = { '@block.outer', '@conditional.outer', '@loop.outer' },
					i = { '@block.inner', '@conditional.inner', '@loop.inner' },
				}, {}),
				f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }, {}),
				c = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }, {}),
			},
		}
	end)

	require "mini.surround".setup {
		mappings = {
			add = 'ma',
			delete = 'md',
			find = 'mf',
			find_left = 'mF',
			highlight = 'mh',
			replace = 'mr',
			update_n_lines = 'mn',
		},
	}

	--
	-- Looks
	--

	require "mini.statusline".setup()
end)
