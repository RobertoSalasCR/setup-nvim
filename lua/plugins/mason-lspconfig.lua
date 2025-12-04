return {
    'williamboman/mason-lspconfig.nvim',
    config = function()
        require('mason-lspconfig').setup({
            ensure_installed = {
                'lua_ls',
                'gopls',
                'templ',
                'html',
                'cssls',
                'marksman',
                'markdown_oxide',
                'rust_analyzer',
                'elixirls',
                'ols',
                'zls',
            },
        })
    end
}
