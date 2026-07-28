local M = {
	program = nil,
	args = nil,
}

--- Debuggee for this session. Uses `guess` when it points at something runnable,
--- otherwise picks from the executables under the cwd. Remembered.
function M.getProgram(guess)
	if M.program == nil then
		local picked = guess and vim.fn.executable(guess) == 1 and guess
			or require "dap.utils".pick_file { path = vim.fn.getcwd() }

		if type(picked) ~= "string" then return require "dap".ABORT end
		M.program = picked
	end

	return M.program
end

--- Arguments for this session with possible quotes.
function M.getArgs()
	if M.args == nil then
		M.args = require "dap.utils".splitstr(vim.fn.input("Args: "))
	end

	return M.args
end

function M.reset()
	M.program, M.args = nil, nil
end

return M
