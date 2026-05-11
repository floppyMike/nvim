require "mini.tabline".setup()

vim.api.nvim_create_autocmd("FileType", { -- Quicklist buffers don't appear in bufferlist
	desc = "Unlist quickfist buffers",
	group = vim.api.nvim_create_augroup("unlist_quickfist", { clear = true }),
	pattern = "qf",
	callback = function() vim.opt_local.buflisted = false end,
})

vim.keymap.set("n", keymap.VerticalSplit, "<cmd>vsplit<cr>", { desc = "Vertical Split" })
vim.keymap.set("n", keymap.HorizontalSplit, "<cmd>split<cr>", { desc = "Horizontal Split" })
vim.keymap.set("n", keymap.JumpUpWindow, "<cmd>wincmd k<cr>", { desc = "Move to top split" })
vim.keymap.set("n", keymap.JumpDownWindow, "<cmd>wincmd j<cr>", { desc = "Move to bottom split" })
vim.keymap.set("n", keymap.JumpLeftWindow, "<cmd>wincmd h<cr>", { desc = "Move to left split" })
vim.keymap.set("n", keymap.JumpRightWindow, "<cmd>wincmd l<cr>", { desc = "Move to right split" })
vim.keymap.set("n", keymap.ResizeUpWindow, "<cmd>resize +2<CR>", { desc = "Resize split up" })
vim.keymap.set("n", keymap.ResizeDownWindow, "<cmd>resize -2<CR>", { desc = "Resize split down" })
vim.keymap.set("n", keymap.ResizeLeftWindow, "<cmd>vertical resize +2<CR>", { desc = "Resize split left" })
vim.keymap.set("n", keymap.ResizeRightWindow, "<cmd>vertical resize -2<CR>", { desc = "Resize split right" })

vim.keymap.set("n", keymap.LocationToggle,
	function()
		for _, win in ipairs(vim.fn.getwininfo()) do
			if win.loclist == 1 then
				vim.cmd("lclose")
				return
			end
		end
		vim.cmd("lopen")
	end, { desc = "Close location list" })

vim.keymap.set("n", keymap.QuickfixToggle,
	function()
		for _, win in ipairs(vim.fn.getwininfo()) do
			if win.quickfix == 1 then
				vim.cmd("cclose")
				return
			end
		end
		vim.cmd("copen")
	end, { desc = "Close quickfix list" })

vim.keymap.set("n", keymap.BufferDelete, require "mini.bufremove".wipeout,
	{ desc = "Delete current buffer without messing up split" })
