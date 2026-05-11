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

dap.configurations.zig = {
	{
		name = "launch",
		type = "lldb",
		request = "launch",
		program = function() return dapcfg.getProgram("zig-out/bin/" .. vim.fs.basename(vim.fn.getcwd())) end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = dapcfg.getArgs,
	},
}

vim.keymap.set("n", keymap.DAPContinue, dap.continue)
vim.keymap.set("n", keymap.DAPstepout, dap.step_out)
vim.keymap.set("n", keymap.DAPstepover, dap.step_over)
vim.keymap.set("n", keymap.DAPstepinto, dap.step_into)
vim.keymap.set("n", keymap.DAPrepl, function() dap.repl.toggle({ height = 15 }) end)
vim.keymap.set("n", keymap.DAPtogglebreak, dap.toggle_breakpoint)
vim.keymap.set("n", keymap.DAPtogglescope, scope.toggle)
vim.keymap.set("n", keymap.DAPtoggleframe, frame.toggle)

vim.keymap.set("n", keymap.DAPreset, function()
	vim.notify("Reset DAP configuration")
	dapcfg.reset()
end)

