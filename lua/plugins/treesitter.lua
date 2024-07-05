return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
        require('nvim-treesitter.configs').setup({
            ensure_installed = {
                'lua',
                'vim',
                'vimdoc',
                'javascript',
                'html',
                'css',
                'go',
                'gomod',
                'gosum',
                'gotmpl',
                'gowork',
            },
            hightlight = {
                enable = true,
            },
        })
    end
}
