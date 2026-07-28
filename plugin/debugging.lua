local dapcfg = require "dapconfig"

local dap = require "dap"
local dapwidgets = require "dap.ui.widgets"
local scope = dapwidgets.sidebar(dapwidgets.scopes, { width = 75 })
local frame = dapwidgets.sidebar(dapwidgets.frames, { width = 75 })

dap.adapters.lldb = {
	type = "executable",
	command = "lldb-dap",
	name = "lldb",
}

--- One lldb launch config. `guess` means use the defaults.
local function launch(guess)
	return { {
		name = "launch",
		type = "lldb",
		request = "launch",
		program = function() return dapcfg.getProgram(guess and guess()) end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = dapcfg.getArgs,
	} }
end

local project = function() return vim.fs.basename(vim.fn.getcwd()) end

dap.configurations.zig = launch(function() return "zig-out/bin/" .. project() end)
dap.configurations.rust = launch(function() return "target/debug/" .. project() end)
dap.configurations.c = launch()
dap.configurations.cpp = dap.configurations.c

vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn" })
vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "DiagnosticHint" })
vim.fn.sign_define("DapLogPoint", { text = "◇", texthl = "DiagnosticInfo" })
vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticOk", linehl = "CursorLine" })

vim.keymap.set("n", keymap.DAPContinue, dap.continue, { desc = "Start or continue debugging" })
vim.keymap.set("n", keymap.DAPstepout, dap.step_out, { desc = "Step out of frame" })
vim.keymap.set("n", keymap.DAPstepover, dap.step_over, { desc = "Step over line" })
vim.keymap.set("n", keymap.DAPstepinto, dap.step_into, { desc = "Step into call" })
vim.keymap.set("n", keymap.DAPrepl, function() dap.repl.toggle({ height = 15 }) end,
	{ desc = "Toggle debug REPL and program output" })
vim.keymap.set("n", keymap.DAPtogglebreak, dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
vim.keymap.set("n", keymap.DAPtogglescope, scope.toggle, { desc = "Toggle variable scopes" })
vim.keymap.set("n", keymap.DAPtoggleframe, frame.toggle, { desc = "Toggle call frames" })

vim.keymap.set("n", keymap.DAPreset, function()
	dap.terminate()
	dapcfg.reset()
	vim.notify("Stopped session, cleared program and args")
end, { desc = "Stop debugging and forget program and args" })
