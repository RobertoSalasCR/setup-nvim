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
                'json',
                'html',
                'css',
                'styled',
                'go',
                'printf',
                'gomod',
                'gosum',
                'gotmpl',
                'gowork',
                'templ',
                'proto',
                'markdown',
                'mermaid',
                'toml',
            },
            hightlight = {
                enable = true,
                disable = { 'org' },
            },
        })
    end
}
