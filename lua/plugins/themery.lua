--
--For permanent theme change go to config/lazy.lua and modify colorscheme property.
--
return {
    "zaldih/themery.nvim",
    lazy = false,
    config = function()
        require("themery").setup({
            themes = {
                {
                    name = 'Adwaita',
                    colorscheme = 'adwaita',
                },
                {
                    name = 'Aurora',
                    colorscheme = 'aurora',
                },
                {
                    name = 'Ayu',
                    colorscheme = 'ayu',
                },
                {
                    name = 'Bamboo',
                    colorscheme = 'bamboo',
                },
                {
                    name = 'Bamboo Light',
                    colorscheme = 'bamboo-light',
                },
                {
                    name = 'Bamboo Multiplex',
                    colorscheme = 'bamboo-multiplex',
                },
                {
                    name = 'Bamboo Vulgaris',
                    colorscheme = 'bamboo-vulgaris',
                },
                {
                    name = 'Biogoo',
                    colorscheme = 'biogoo',
                },
                {
                    name = 'Blue',
                    colorscheme = 'blue',
                },
                {
                    name = 'Borland',
                    colorscheme = 'borland',
                },
                {
                    name = 'Catppuccin',
                    colorscheme = 'catppuccin',
                },
                {
                    name = 'Dark Blue',
                    colorscheme = 'darkblue',
                },
                {
                    name = 'Darker',
                    colorscheme = 'darker',
                },
                {
                    name = 'Dark Solar',
                    colorscheme = 'darksolar',
                },
                {
                    name = 'Deep Ocean',
                    colorscheme = 'deepocean',
                },
                {
                    name = 'Default',
                    colorscheme = 'default',
                },
                {
                    name = 'Delek',
                    colorscheme = 'delek',
                },
                {
                    name = 'Desert',
                    colorscheme = 'desert',
                },
                {
                    name = 'Dracula',
                    colorscheme = 'dracula',
                },
                {
                    name = 'Dracula Blood',
                    colorscheme = 'dracula_blood',
                },
                {
                    name = 'Early Summer',
                    colorscheme = 'earlysummer',
                },
                {
                    name = 'Emerald',
                    colorscheme = 'emerald',
                },
                {
                    name = 'Evening',
                    colorscheme = 'evening',
                },
                {
                    name = 'Ever Forest',
                    colorscheme = 'everforest',
                },
                {
                    name = 'Github Light Default',
                    colorscheme = 'github_light_default',
                },
                {
                    name = 'Github Light High Contrast',
                    colorscheme = 'github_light_high_contrast',
                },
                {
                    name = 'Github Light Tritanopia',
                    colorscheme = 'github_light_tritanopia',
                },
                {
                    name = 'Github Dark Default',
                    colorscheme = 'github_dark_default',
                },
                {
                    name = 'Github Dark Dimmed',
                    colorscheme = 'github_dark_dimmed',
                },
                {
                    name = 'Github Dark High Contrast',
                    colorscheme = 'github_dark_high_contrast',
                },
                {
                    name = 'Github Dark Tritanopia',
                    colorscheme = 'github_dark_tritanopia',
                },
                {
                    name = 'Gruvbox',
                    colorscheme = 'gruvbox',
                },
                {
                    name = 'Habamax',
                    colorscheme = 'habamax',
                },
                {
                    name = 'Kanagawa Dragon',
                    colorscheme = 'kanagawa-dragon',
                },
                {
                    name = 'Kanagawa Lotus',
                    colorscheme = 'kanagawa-lotus',
                },
                {
                    name = 'Kanagawa Paper',
                    colorscheme = 'kanagawa-paper',
                },
                {
                    name = 'Kanagawa Paper Canvas',
                    colorscheme = 'kanagawa-paper-canvas',
                },
                {
                    name = 'Kanagawa Paper Ink',
                    colorscheme = 'kanagawa-paper-ink',
                },
                {
                    name = 'Kanagawa Wave',
                    colorscheme = 'kanagawa-wave',
                },
                {
                    name = 'Lackluster',
                    colorscheme = 'lackluster',
                },
                {
                    name = 'Lackluster Dark',
                    colorscheme = 'lackluster-dark',
                },
                {
                    name = 'Lackluster Mint',
                    colorscheme = 'lackluster-mint',
                },
                {
                    name = 'Lackluster Night',
                    colorscheme = 'lackluster-night',
                },
                {
                    name = 'Lightning',
                    colorscheme = 'lightning',
                },
                {
                    name = 'Lunaperche',
                    colorscheme = 'lunaperche',
                },
                {
                    name = 'Mariana',
                    colorscheme = 'mariana',
                },
                {
                    name = 'Matrix',
                    colorscheme = 'matrix',
                },
                {
                    name = 'Melange',
                    colorscheme = 'melange',
                },
                {
                    name = 'Miasma',
                    colorscheme = 'miasma',
                },
                {
                    name = 'Middlenight Blue',
                    colorscheme = 'middlenight_blue',
                },
                {
                    name = 'Minimal',
                    colorscheme = 'minimal',
                },
                {
                    name = 'Minimal Base16',
                    colorscheme = 'minimal-base16',
                },
                {
                    name = 'Modus',
                    colorscheme = 'modus',
                },
                {
                    name = 'Modus Operandi',
                    colorscheme = 'modus_operandi',
                },
                {
                    name = 'Modus Vivendi',
                    colorscheme = 'modus_vivendi',
                },
                {
                    name = 'Monokai',
                    colorscheme = 'monokai',
                },
                {
                    name = 'Moonlight',
                    colorscheme = 'moonlight',
                },
                {
                    name = 'Morning',
                    colorscheme = 'morning',
                },
                {
                    name = 'Murphy',
                    colorscheme = 'murphy',
                },
                {
                    name = 'Neo Solarized',
                    colorscheme = 'NeoSolarized',
                },
                {
                    name = 'Neo Fusion',
                    colorscheme = 'neofusion',
                },
                {
                    name = 'Nordern',
                    colorscheme = 'nordern',
                },
                {
                    name = 'Oceanic',
                    colorscheme = 'oceanic',
                },
                {
                    name = 'Oxocarbon',
                    colorscheme = 'oxocarbon',
                },
                {
                    name = 'Paper Color',
                    colorscheme = 'PaperColor',
                },
                {
                    name = 'Pale Night',
                    colorscheme = 'palenight',
                },
                {
                    name = 'Peach Puff',
                    colorscheme = 'peachpuff',
                },
                {
                    name = 'Poimandres',
                    colorscheme = 'poimandres',
                },
                {
                    name = 'Psionic',
                    colorscheme = 'psionic',
                },
                {
                    name = 'Quiet',
                    colorscheme = 'quiet',
                },
                {
                    name = 'Retrobox',
                    colorscheme = 'retrobox',
                },
                {
                    name = 'Ron',
                    colorscheme = 'ron',
                },
                {
                    name = 'Rose Pine',
                    colorscheme = 'rosepine',
                },
                {
                    name = 'Rose Pine Dawn',
                    colorscheme = 'rosepine_dawn',
                },
                {
                    name = 'Rose Pine Moon',
                    colorscheme = 'rosepine_moon',
                },
                {
                    name = 'Shine',
                    colorscheme = 'shine',
                },
                {
                    name = 'Slate',
                    colorscheme = 'slate',
                },
                {
                    name = 'Slate',
                    colorscheme = 'slate',
                },
                {
                    name = 'Sorbet',
                    colorscheme = 'sorbet',
                },
                {
                    name = 'Space Nvim',
                    colorscheme = 'space-nvim',
                },
                {
                    name = 'Starry',
                    colorscheme = 'starry',
                },
                {
                    name = 'Sweetie',
                    colorscheme = 'sweetie',
                },
                {
                    name = 'Tokyo Night',
                    colorscheme = 'tokyonight',
                },
                {
                    name = 'Ukraine',
                    colorscheme = 'ukraine',
                },
                {
                    name = 'Unokai',
                    colorscheme = 'unokai',
                },
                {
                    name = 'Vim',
                    colorscheme = 'vim',
                },
                {
                    name = 'Visual Studio Code',
                    colorscheme = 'visual_studio_code',
                },
                {
                    name = 'Wild Charm',
                    colorscheme = 'wildcharm',
                },
                {
                    name = 'Zaibatsu',
                    colorscheme = 'zaibatsu',
                },
                {
                    name = 'Zellner',
                    colorscheme = 'zellner',
                },
            },
        })
    end
}
