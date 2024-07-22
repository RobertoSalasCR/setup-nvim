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
            auto_install = true,
            hightlight = {
                enable = true,
                disable = { 'org' },
                aditional_vim_regex_highlighting = true,
            },
            incremental_selection = { enable = true },
            textobjects = { enable = true },
        })
    end
}
