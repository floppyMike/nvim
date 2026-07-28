require "mini.git".setup()
require "mini.diff".setup {
	view = {
		style = "sign",
		signs = { add = '+', change = '~', delete = '-' }
	},
	mappings = {
		apply = keymap.GitApply,
		reset = keymap.GitReset,
		goto_first = '',
		goto_prev = keymap.PrevChange,
		goto_next = keymap.NextChange,
		goto_last = '',
	},
	options = {
		wrap_goto = true,
	},
}

--- Create fold expressions for mini.git buffers (and auto collapse)
vim.api.nvim_create_autocmd("FileType", {
	desc = "Fold unified diff output",
	group = vim.api.nvim_create_augroup("git_diff_folds", { clear = true }),
	pattern = { "diff", "git" },
	callback = function(ev)
		vim.wo[0][0].foldmethod = "expr"
		vim.wo[0][0].foldexpr = "v:lua.MiniGit.diff_foldexpr()"
		vim.wo[0][0].foldlevel = ev.match == "diff" and 1 or 0
	end,
})

local claim_tab = require "tab".claim_tab

--- Open `fn` in "git" tab and delete previously used tab
local function in_git_tab(fn)
	return function()
		local before = vim.api.nvim_get_current_tabpage()
		if not pcall(fn) then return end
		if vim.api.nvim_get_current_tabpage() ~= before then claim_tab("git") end
	end
end

vim.keymap.set("n", keymap.GitToggleOverlay, MiniDiff.toggle_overlay, { desc = "Toggle diff overlay" })

vim.keymap.set({ "n", "x" }, keymap.GitTrackLine, in_git_tab(MiniGit.show_at_cursor),
	{ desc = "Show git data at cursor" })

vim.keymap.set("n", keymap.GitDiffBoth, in_git_tab(function() MiniGit.show_diff_source({ target = "both" }) end),
	{ desc = "Show diff source, before and after" })

vim.keymap.set("n", keymap.GitHunkPick, MiniExtra.pickers.git_hunks, { desc = "Pick unstaged hunk" })
vim.keymap.set("n", keymap.GitFilePick, MiniExtra.pickers.git_files, { desc = "Pick git file" })

vim.keymap.set("n", keymap.GitCommitPick, function()
	local buf_path = vim.api.nvim_buf_get_name(0)
	MiniExtra.pickers.git_commits({ path = vim.fn.filereadable(buf_path) == 1 and buf_path or nil })
end, { desc = "Pick commit touching current file" })

vim.keymap.set("n", keymap.GitBranchDiff, in_git_tab(function()
	local c1 = vim.fn.input("Diff against commit (empty for HEAD): ")
	vim.cmd("Git diff " .. (c1 == "" and "HEAD" or c1))
end), { desc = "Diff working tree against a commit" })
