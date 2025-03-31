--
-- DAP configuration persistance
--

local M = {
	program = nil,
	args = {},
}

function M.getProgram(default)
	if M.program == nil then
		M.program = default or vim.fn.input('Path to executable: ', "", 'file')
	end

	return M.program
end

function M.getArgs()
	if #M.args == 0 then
		local i = 1
		while true do
			local input = vim.fn.input("Arg " .. i .. ": ")
			if input == "" then
				break
			end
			table.insert(M.args, input)
			i = i + 1
		end
	end

	return M.args
end

function M.reset()
	M.program = nil
	M.args = {}
end

--
-- DAP configuration
--

require "pluginmanager".ensure("mfussenegger", "nvim-dap", {}, function()
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
			program = function() return M.getProgram("zig-out/bin/" .. vim.fs.basename(vim.fn.getcwd())) end,
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
			args = M.getArgs,
		},
	}

	vim.keymap.set("n", "<F1>", dap.continue)
	vim.keymap.set("n", "<F2>", dap.step_out)
	vim.keymap.set("n", "<F3>", dap.step_over)
	vim.keymap.set("n", "<F4>", dap.step_into)
	vim.keymap.set("n", "<F5>", function() dap.repl.toggle({ height = 15 }) end)

	vim.keymap.set("n", "<leader>n", dap.toggle_breakpoint)
	vim.keymap.set("n", "<leader>N", function()
		vim.notify("Reset DAP configuration")
		M.reset()
	end)

	vim.keymap.set("n", "<leader>m", scope.toggle)
	vim.keymap.set("n", "<leader>M", frame.toggle)
end)
