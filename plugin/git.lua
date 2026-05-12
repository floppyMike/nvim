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

local reset_line = function(ev, l)
	local rel = l:match("([^%s]+)%s*$")
	vim.cmd("Git restore " .. vim.fn.fnameescape(vim.fs.joinpath(ev.data.cwd, rel)))
	vim.notify("Reset " .. rel, vim.log.levels.INFO)
end

local stage_line = function(ev, l)
	local rel = l:match("([^%s]+)%s*$")
	vim.cmd("Git add " .. vim.fn.fnameescape(vim.fs.joinpath(ev.data.cwd, rel)))
	vim.notify("Staged " .. rel, vim.log.levels.INFO)
end

local unstage_line = function(ev, l)
	local rel = l:match("([^%s]+)%s*$")
	vim.cmd("Git restore --staged " .. vim.fn.fnameescape(vim.fs.joinpath(ev.data.cwd, rel)))
	vim.notify("Unstaged " .. rel, vim.log.levels.INFO)
end

vim.api.nvim_create_autocmd('User', {
	pattern = 'MiniGitCommandSplit',
	callback = function(ev)
		if ev.data.git_subcommand ~= 'status' then return end

		vim.keymap.set('n', '<CR>', function()
			local rel = vim.api.nvim_get_current_line():match("([^%s]+)%s*$")
			vim.cmd.tabclose()
			vim.cmd.edit(vim.fn.fnameescape(vim.fs.joinpath(ev.data.cwd, rel)))
		end, {
			buffer = true,
			silent = true,
			desc = 'Open status file and close tab',
		})

		vim.keymap.set('n', "i", function()
			vim.cmd.tabclose()
			vim.cmd("Git status")
		end, {
			buffer = true,
			desc = 'Reload status',
		})

		vim.keymap.set('v', 'a', function()
			for _, l in ipairs(vim.fn.getline("'<", "'>")) do
				stage_line(ev, l)
			end
		end, {
			buffer = true,
			desc = 'Stage paths',
		})

		vim.keymap.set('n', 'a', function()
			stage_line(ev, vim.api.nvim_get_current_line())
		end, {
			buffer = true,
			desc = 'Stage path',
		})

		vim.keymap.set('v', 'D', function()
			for _, l in ipairs(vim.fn.getline("'<", "'>")) do
				reset_line(ev, l)
			end
		end, {
			buffer = true,
			desc = 'Reset paths',
		})

		vim.keymap.set('n', 'D', function()
			reset_line(ev, vim.api.nvim_get_current_line())
		end, {
			buffer = true,
			desc = 'Reset path',
		})

		vim.keymap.set('v', 'd', function()
			for _, l in ipairs(vim.fn.getline("'<", "'>")) do
				unstage_line(ev, l)
			end
		end, {
			buffer = true,
			desc = 'Unstage paths',
		})

		vim.keymap.set('n', 'd', function()
			unstage_line(ev, vim.api.nvim_get_current_line())
		end, {
			buffer = true,
			desc = 'UnStage path',
		})
	end,
})

vim.keymap.set("n", keymap.GitToggleOverlay, MiniDiff.toggle_overlay)
vim.keymap.set("n", keymap.GitTrackLine, MiniGit.show_at_cursor)

vim.keymap.set("n", keymap.GitApplyAll, ":Git add %<cr>")
vim.keymap.set("n", keymap.GitStatus, ":Git status<cr>")
vim.keymap.set("n", keymap.GitCommit, ":Git commit<cr>")
vim.keymap.set("n", keymap.GitCommitAmend, ":Git commit --amend --no-edit<cr>")

vim.keymap.set("n", keymap.GitBranchDiff, function()
	local c1 = vim.fn.input("From Commit: ")
	vim.cmd("Git diff -p --stat " .. c1 .. "..HEAD")
end)
