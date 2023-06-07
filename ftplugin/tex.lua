vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = "*.tex",
	callback = function()
		vim.loop.spawn('pdflatex', {
			args = { vim.api.nvim_buf_get_name(0) },
		}, vim.schedule_wrap(function(code)
			if code == 0 then
				vim.api.nvim_out_write("OK: Latex compiled\n")
			else
				vim.api.nvim_err_writeln("ERROR: Latex errors")
			end
		end))
	end
})
