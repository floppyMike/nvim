local M = {}

local walkers = {} -- Wandering duck windows, oldest first
local headings = {} -- Walking angle of each walker, by window
local followers = {} -- Duckling windows, each trailing the previous, the first the cursor
local timer = nil -- Drives all ducks, nil while there are none
local period = 100 -- ms per step
local gap = 2 -- Distance a duckling keeps to the one ahead

vim.api.nvim_set_hl(0, "Duck", { bg = "none", blend = 100 })

local function wrap(x, max)
	if x < 0 then return max end
	if x > max then return 0 end
	return x
end

local function drop(list, i)
	local win = table.remove(list, i)
	if vim.api.nvim_win_is_valid(win) then vim.api.nvim_win_close(win, true) end
	headings[win] = nil

	if #walkers + #followers == 0 then
		vim.fn.timer_stop(timer)
		timer = nil
	end
end

local function walk(win)
	if math.random() < 0.1 then headings[win] = 2 * math.pi * math.random() end

	local cfg = vim.api.nvim_win_get_config(win)
	vim.api.nvim_win_set_config(win, {
		relative = "editor",
		row = wrap(cfg.row + 0.5 * math.sin(headings[win]), vim.o.lines),
		col = wrap(cfg.col + math.cos(headings[win]), vim.o.columns),
	})
end

local function cursor()
	local pos = vim.fn.screenpos(0, vim.fn.line("."), vim.fn.col("."))
	return pos.row, pos.col -- 1-based, so as float origin it sits below right of the cursor
end

local function follow(win, row, col)
	local cfg = vim.api.nvim_win_get_config(win)
	local dr, dc = row - cfg.row, col - cfg.col
	local dist = math.sqrt(4 * dr * dr + dc * dc) -- Cells are twice as tall as wide
	local f = dist > gap and 0.3 * (dist - gap) / dist or 0

	row, col = cfg.row + f * dr, cfg.col + f * dc
	vim.api.nvim_win_set_config(win, { relative = "editor", row = row, col = col })

	return row, col
end

local function tick()
	for _, list in ipairs({ walkers, followers }) do
		for i = #list, 1, -1 do
			if not vim.api.nvim_win_is_valid(list[i]) then drop(list, i) end -- Closed by e.g. :only
		end
	end

	for _, win in ipairs(walkers) do walk(win) end

	local row, col = cursor()
	for _, win in ipairs(followers) do row, col = follow(win, row, col) end
end

local function open(char)
	local buf = vim.api.nvim_create_buf(false, true)
	vim.bo[buf].bufhidden = "wipe"
	vim.api.nvim_buf_set_lines(buf, 0, -1, true, { char })

	local row, col = cursor()
	local win = vim.api.nvim_open_win(buf, false, {
		relative = "editor", row = row, col = col,
		width = vim.fn.strdisplaywidth(char), height = 1,
		style = "minimal", focusable = false, noautocmd = true,
	})
	vim.wo[win].winhighlight = "Normal:Duck"
	timer = timer or vim.fn.timer_start(period, tick, { ["repeat"] = -1 })

	return win
end

function M.hatch(char)
	local win = open(char)
	table.insert(walkers, win)
	headings[win] = 2 * math.pi * math.random()
end

function M.duckling(char)
	table.insert(followers, open(char))
end

function M.cook()
	local walker, follower = walkers[#walkers] or 0, followers[#followers] or 0

	if walker + follower == 0 then return vim.notify("No ducks to cook!") end

	if walker > follower then drop(walkers, #walkers) else drop(followers, #followers) end -- Window ids grow, the newest is highest
end

function M.cook_all()
	if #walkers + #followers == 0 then return vim.notify("No ducks to cook!") end

	for i = #walkers, 1, -1 do drop(walkers, i) end
	for i = #followers, 1, -1 do drop(followers, i) end
end

return M
