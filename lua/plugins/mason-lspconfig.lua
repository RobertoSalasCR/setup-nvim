return {
    'williamboman/mason-lspconfig.nvim',
    config = function()
        require('mason-lspconfig').setup({
            ensure_installed = {
                'clangd',          -- C/C++
                'lua_ls',          -- Lua
                'gopls',           -- Go
                'templ',           -- Go
                'html',
                'cssls',
                'fortls',          -- Fortran
                'marksman',        -- Markdown
                'markdown_oxide',  -- Markdown
                --'rust_analyzer',   -- Rust
                'elixirls',        -- Elixir
                'ols',             -- Odin
                'zls',             -- Zig 
            },
        })
    end
}
