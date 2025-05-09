return function()
	local capabilities = require('cmp_nvim_lsp').default_capabilities()

	vim.keymap.set('n', 'g[', vim.diagnostic.goto_prev, { desc = "Goto previous error/warning" })
	vim.keymap.set('n', 'g]', vim.diagnostic.goto_next, { desc = "Goto next error/warning" })
	On_attach = function(_, bufnr)
		vim.keymap.set('n', 'gh', vim.lsp.buf.hover, { buffer = bufnr, desc = "Show hover code information" })
		vim.keymap.set('n', 'gH', vim.lsp.buf.code_action, { buffer = bufnr, desc = "Select code action" })
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = "Goto definition" })
		vim.keymap.set('n', 'gD', vim.lsp.buf.implementation, { buffer = bufnr, desc = "Goto implementation" })
		vim.keymap.set('n', 'gr', vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename code symbol" })
		vim.keymap.set('n', 'gR', vim.lsp.buf.references, { buffer = bufnr, desc = "Show code references" })
		vim.keymap.set('n', '<a-i>', vim.lsp.buf.format, { buffer = bufnr })
		vim.keymap.set('i', '<c-k>', vim.lsp.buf.signature_help, { buffer = bufnr })

		vim.keymap.set('i', '<c-n>', function()
			require('luasnip').jump(1)
		end, { buffer = bufnr })
		vim.keymap.set('i', '<c-p>', function()
			require('luasnip').jump(-1)
		end, { buffer = bufnr })

		vim.keymap.set('n', '<leader>d', require('neogen').generate, { buffer = bufnr })
	end

	-- C++
	require('lspconfig').clangd.setup {
		on_attach = function(_, b)
			On_attach(_, b)
			vim.keymap.set('n', '<F6>',
				'<cmd>!cmake -DBENCHMARK=ON -DCMAKE_BUILD_TYPE=Release -S . -B build/ && cmake --build build/ && ./build/benchmark/test2<CR>')
			vim.keymap.set('n', '<F7>',
			'<cmd>!cmake -S . -B build/ -D CMAKE_EXPORT_COMPILE_COMMANDS=1 && cmake --build build/<CR>')
			vim.keymap.set('n', '<F9>',
				'<cmd>!cmake -DCMAKE_BUILD_TYPE=Release -S . -B release/ && cmake --build release/<CR>')
			vim.keymap.set('n', '<F10>',
				'<cmd>!cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo -S . -B release/ && cmake --build release/<CR>')
			vim.keymap.set('n', '<F8>',
				'<cmd>!cmake -S . -B build/ && cmake --build build/ && ./build/' ..
				vim.fn.substitute(vim.fn.getcwd(), '^.*/', '', '') .. '<CR>')
		end,
		capabilities = capabilities,
	}

	-- Rust
	require('lspconfig').rust_analyzer.setup {
		on_attach = function(_, b)
			On_attach(_, b)
			vim.keymap.set('n', '<F5>', '<cmd>!RUST_BACKTRACE=1 cargo test -- nocapture<CR>')
			vim.keymap.set('n', '<F6>', '<cmd>!cargo run<CR>')
			vim.keymap.set('n', '<F7>', '<cmd>!cargo build<CR>')
			vim.keymap.set('n', '<F8>', '<cmd>!RUST_LOG=trace cargo run<CR>')
			vim.keymap.set('n', '<F9>', '<cmd>!cargo build --release<CR>')
			vim.keymap.set('n', '<leader>r', '<cmd>CargoReload<CR>')
		end,
		capabilities = capabilities,
	}

	-- Spelling for Latex & Markdown
	require('lspconfig').ltex.setup {
		on_attach = function(_, b)
			On_attach(_, b)
		end,
		capabilities = capabilities,
	}

	-- Latex
	require('lspconfig').texlab.setup {
		on_attach = function(_, b)
			On_attach(_, b)
			vim.keymap.set('n', '<F7>', function()
				vim.loop.spawn('zathura', {
					args = { (vim.api.nvim_buf_get_name(0):gsub("%.tex$", ".pdf")) },
				}, vim.schedule_wrap(function(code)
					if code == 0 then
						vim.api.nvim_out_write("OK: Closed PDF viewer\n")
					else
						vim.api.nvim_err_writeln("ERROR: Couldnt open PDF viewer")
					end
				end))
			end)
		end,
		capabilities = capabilities,
	}

	-- Python
	require 'lspconfig'.pyright.setup {
		on_attach = function(_, b)
			On_attach(_, b)
			vim.keymap.set('n', '<F7>', '<cmd>!python \'' .. vim.api.nvim_buf_get_name(0) .. '\'<CR>')
		end,
		capabilities = capabilities,
	}

	-- Bash
	require 'lspconfig'.bashls.setup {
		on_attach = function(_, b)
			On_attach(_, b)
		end,
		capabilities = capabilities,
	}

	-- Markdown
	require 'lspconfig'.marksman.setup {
		on_attach = function(_, b)
			On_attach(_, b)
			vim.keymap.set('n', '<F7>', '<cmd>!codium --disable-extensions --profile "MarkdownPreview" \'' .. vim.api.nvim_buf_get_name(0) .. '\'<CR>')
		end,
		capabilities = capabilities,
	}

	-- Haskell
	require 'lspconfig'.hls.setup {
		filetypes = { 'haskell', 'lhaskell', 'cabal' },
		on_attach = function(_, b)
			On_attach(_, b)
		end,
		capabilities = capabilities,
	}

	-- Zig
	require 'lspconfig'.zls.setup {
		cmd = { vim.env.HOME .. "/.local/zig-linux-x86_64-0.11.0-dev/zls" },
		root_pattern = { "zls.json", ".git", "build.zig" },
		on_attach = function(_, b)
			On_attach(_, b)
			vim.keymap.set('n', '<F7>', "<cmd>!" .. vim.env.HOME .. "/.local/zig-linux-x86_64-0.11.0-dev/zig build<CR>")
			vim.keymap.set('n', '<F8>',
			"<cmd>!" .. vim.env.HOME .. "/.local/zig-linux-x86_64-0.11.0-dev/zig build run<CR>")
		end,
		capabilities = capabilities,
	}

	-- Lua
	require 'lspconfig'.lua_ls.setup {
		on_attach = function(_, b)
			On_attach(_, b)
		end,
		capabilities = capabilities,
	}

	-- Typescript
	require 'lspconfig'.tsserver.setup {
		on_attach = function(_, b)
			On_attach(_, b)
		end,
		capabilities = capabilities,
	}

	-- Julia
	require 'lspconfig'.julials.setup {
		on_attach = function(_, b)
			On_attach(_, b)
			vim.keymap.set('n', '<F7>', '<cmd>!julia \'' .. vim.api.nvim_buf_get_name(0) .. '\'<CR>')
		end,
		capabilities = capabilities,
	}
end
