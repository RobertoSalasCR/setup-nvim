return {
    'RedsXDD/neopywal.nvim',
    name = 'neopywal',
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
        require('neopywal').setup({
            use_palette = 'onedark',
            transparent_background = true,
            terminal_colors = true,
            show_end_of_buffer = false,
            show_split_lines = true,
            default_plugins = true,
            default_fileformats = true,
            styles = {
                comments = { 'italic' },
                conditionals = {},
                loops = {},
                functions = { 'bold' },
                keywords = {},
                includes = { 'italic' },
                strings = {},
                variables = { 'bold' },
                numbers = {},
                boolens = {},
                types = { 'italic' },
                operators = { 'bold' },
            },
        })
    end
}

-- To achieve this, use the use_palette option with one of the following available colorscheme palette names:
-- 
-- catppuccin-{frappe,macchiato,mocha}
-- doomone
-- everforest-{soft,medium,hard}
-- gruvbox-{soft,dark,hard}
-- material and material-{darker,ocean,palenight}
-- monokaipro
-- nord
-- oceanic-next
-- onedark and onedark-{darker,vivid}
-- palenight
-- solarized
-- sonokai
-- tokyonight and tokyonight-storm
-- tommorow-night

