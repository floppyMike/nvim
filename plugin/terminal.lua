local tab = require "tab"

vim.t.role = "code" -- Adopt the startup tab, so <m-1> never strands itself on a fresh one

vim.keymap.set({ "n", "i", "t" }, "<m-1>", function() tab.go_tab("code") end)
vim.keymap.set({ "n", "i", "t" }, "<m-2>", function() tab.go_tab("lazygit", "lazygit") end)
vim.keymap.set({ "n", "i", "t" }, "<m-3>", function() tab.jump_tab("git") end)

for i = 4, 9 do
	vim.keymap.set({ "n", "i", "t" }, "<m-" .. i .. ">", function() tab.go_tab("scratch" .. i) end)
end

for key, split in pairs {
	[keymap.ShellVerticalSplit] = "vsplit",
	[keymap.ShellHorizontalSplit] = "split",
} do
	vim.keymap.set({ "n", "i", "t" }, key, function()
		vim.cmd(split .. " | terminal")
		vim.cmd("startinsert")
	end, { desc = "Shell in " .. split })
end

--- Stop showing `win`'s buffer, closing the window unless it's the last of its tab
local function vacate(win)
	if #vim.api.nvim_tabpage_list_wins(vim.api.nvim_win_get_tabpage(win)) == 1 then
		require "mini.bufremove".unshow_in_window(win)
	else
		vim.api.nvim_win_close(win, true)
	end
end

vim.api.nvim_create_autocmd("BufWinEnter", {
	desc = "Show a terminal in one window only, so its size follows that window",
	group = vim.api.nvim_create_augroup("terminal_one_window", { clear = true }),
	callback = function(ev)
		if vim.bo[ev.buf].buftype ~= "terminal" then return end

		local cur = vim.api.nvim_get_current_win()
		for _, win in ipairs(vim.fn.win_findbuf(ev.buf)) do
			if win ~= cur then vacate(win) end
		end
	end
})

--- Find a buffer with assigned role
local function find_buf(role)
	for _, b in ipairs(vim.api.nvim_list_bufs()) do
		if vim.b[b].role == role then return b end
	end
end

--- Run claude in the current window, vacating its windows when it exits
local function spawn_vacated(name)
	vim.cmd("terminal " .. name)

	local buf = vim.api.nvim_get_current_buf()
	vim.b[buf].role = name
	pcall(vim.cmd, "keepalt file " .. name)

	vim.api.nvim_create_autocmd("TermClose", {
		buffer = buf,
		callback = function()
			vim.schedule(function()
				for _, win in ipairs(vim.fn.win_findbuf(buf)) do vacate(win) end
				vim.api.nvim_buf_delete(buf, { force = true })
			end)
		end
	})
end

--- Show the buffer with the role in the current window, calling `make` when missing
local function show(role, make)
	local buf = find_buf(role)
	if buf then vim.api.nvim_set_current_buf(buf) else make() end
end

local specials = {
	claude = function() show("claude", spawn_vacated("claude")) end,
	compile = function() show("compile", function() vim.notify("No compile output", vim.log.levels.WARN) end) end,
	shell = function() vim.cmd("terminal") end,
	pi = function() show("pi", spawn_vacated("pi")) end,
}

vim.keymap.set("n", keymap.SpecialPick, function()
	MiniPick.start { source = {
		name = "Special buffers",
		items = vim.fn.sort(vim.tbl_keys(specials)),
		choose = function(item)
			vim.schedule(function() -- Runs once the picker closed
				specials[item]()
				if vim.bo.buftype == "terminal" then vim.cmd("startinsert") end
			end)
		end,
	} }
end, { desc = "Pick special buffer for this window" })

vim.api.nvim_create_autocmd("TermOpen", {
	callback = function(ev)
		local opts = { buffer = ev.buf }

		vim.keymap.set("t", keymap.TermNormal, "<c-\\><c-n>", opts)
		vim.keymap.set("t", keymap.ZoomWindow, "<c-\\><c-n><cmd>lua MiniMisc.zoom()<cr>i", opts)

		for key, dir in pairs {
			[keymap.TermJumpUpWindow] = "k",
			[keymap.TermJumpDownWindow] = "j",
			[keymap.TermJumpLeftWindow] = "h",
			[keymap.TermJumpRightWindow] = "l",
		} do
			vim.keymap.set("t", key, "<c-\\><c-n><cmd>wincmd " .. dir .. "<cr>", opts)
		end
	end
})
