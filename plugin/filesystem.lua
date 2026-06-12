require "mini.files".setup()
vim.keymap.set("n", keymap.Filesytem, MiniFiles.open)

vim.api.nvim_create_autocmd("User", {
	pattern = "MiniFilesBufferCreate",
	callback = function(args)
		local buf = args.data.buf_id

		vim.keymap.set('n', 'ge', function()
			local entry = MiniFiles.get_fs_entry()
			if not entry then return vim.notify("Invalid item", vim.log.levels.ERROR) end

			vim.system({"extract", entry.name}, { cwd = vim.fs.dirname(entry.path) }, function(obj)
				vim.schedule(function()
					if obj.code == 0 then
						vim.notify("Extracted: " .. entry.name, vim.log.levels.INFO)
						MiniFiles.refresh()
					else
						vim.notify("Extraction failed: " .. (obj.stderr or "error"), vim.log.levels.ERROR)
					end
				end)
			end)
		end, { buffer = buf, desc = 'Extract archive' })
	end,
})
