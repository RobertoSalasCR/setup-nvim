return {
    'williamboman/mason-lspconfig.nvim',
    config = function()
        require('mason-lspconfig').setup({
            ensure_installed = {
                'lua_ls',
                'gopls',
                'html',
                'cssls',
                'tsserver',
                'marksman',
                'markdown_oxide',
            },
        })
    end
}
