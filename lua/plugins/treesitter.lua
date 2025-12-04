return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
        require('nvim-treesitter.configs').setup({
            -- Lenguajes a instalar automáticamente
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
                'odin',
                'rust',
                'elixir',
                'pascal',
                'zig',
                'nim',
                'nim_format_string',
                'python',
                'c_sharp',
                'fsharp',
                'fortran',
            },
            -- *CLAVE:* Ignora la instalación del parser 'org' para evitar conflictos con orgmode.nvim
            ignore_install = { 'org' },
            auto_install = true,
            -- CORRECCIÓN: 'hightlight' debe ser 'highlight'
            highlight = {
                enable = true,
                disable = { 'org' },
                aditional_vim_regex_highlighting = true,
            },
            incremental_selection = { enable = true },
            textobjects = { enable = true },
        })
    end
}
