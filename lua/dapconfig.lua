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

return M
