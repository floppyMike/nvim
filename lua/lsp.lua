return function()
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    vim.keymap.set('n', 'g[', vim.diagnostic.goto_prev)
    vim.keymap.set('n', 'g]', vim.diagnostic.goto_next)
    On_attach = function(_, bufnr)
        vim.keymap.set('n', 'gh', vim.lsp.buf.hover, { buffer = bufnr })
        vim.keymap.set('n', 'gH', vim.lsp.buf.code_action, { buffer = bufnr })
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr })
        vim.keymap.set('n', 'gD', vim.lsp.buf.implementation, { buffer = bufnr })
        vim.keymap.set('n', 'gr', vim.lsp.buf.rename, { buffer = bufnr })
        vim.keymap.set('n', 'gR', vim.lsp.buf.references, { buffer = bufnr })
        vim.keymap.set('n', '<a-i>', vim.lsp.buf.format, { buffer = bufnr })
        vim.keymap.set('i', '<c-k>', vim.lsp.buf.signature_help, { buffer = bufnr })

        vim.keymap.set('i', '<c-n>', function()
            require('luasnip').jump(1)
        end, { buffer = bufnr })
        vim.keymap.set('i', '<c-p>', function()
            require('luasnip').jump( -1)
        end, { buffer = bufnr })
    end

    -- C++
    require('lspconfig').clangd.setup {
        on_attach = function(_, b)
            On_attach(_, b)
            vim.keymap.set('n', '<F6>',
                '<cmd>!cmake -DBENCHMARK=ON -DCMAKE_BUILD_TYPE=Release -S . -B build/ && cmake --build build/ && ./build/benchmark/test2<CR>')
            vim.keymap.set('n', '<F7>', '<cmd>!cmake -S . -B build/ && cmake --build build/<CR>')
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

    -- Latex
    require('lspconfig').texlab.setup {
        on_attach = function(_, b)
            On_attach(_, b)
            vim.keymap.set('n', '<F7>', '<cmd>!pdflatex \'' .. vim.api.nvim_buf_get_name(0) .. '\'<CR>')
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
            vim.keymap.set('n', '<F7>',
                '<cmd>!marp --theme-set ~/OneDrive/Uni/marp --pdf \'' .. vim.api.nvim_buf_get_name(0) .. '\'<CR>')
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
        root_pattern = { "zls.json", ".git", "build.zig" },
        on_attach = function(_, b)
            On_attach(_, b)
            vim.keymap.set('n', '<F7>', '<cmd>!zig build<CR>')
            vim.keymap.set('n', '<F8>', '<cmd>!zig build run<CR>')
        end,
        capabilities = capabilities,
	}

	-- Lua
	require'lspconfig'.lua_ls.setup {
        on_attach = function(_, b)
            On_attach(_, b)
        end,
        capabilities = capabilities,
	}

	-- Typescript
	require'lspconfig'.tsserver.setup {
        on_attach = function(_, b)
            On_attach(_, b)
        end,
        capabilities = capabilities,
	}

end
