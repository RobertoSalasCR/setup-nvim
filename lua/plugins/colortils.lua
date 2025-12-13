return {
    'max397574/colortils.nvim',
    dependencies = {
        'norcalli/nvim-colorizer.lua',
    },
    event = 'VeryLazy',
    cmd = 'Colortils',
    config = function()
        require('colorizer').setup({})
        require('colortils').setup({
            register = '+',
        })
        local wk = require('which-key')
        wk.add({
            { '<leader>c',   group = 'Code' },
            { '<leader>cP',  group = 'Pickers' },
            { '<leader>cPc', '<cmd>Colortils css list<cr>', desc = 'Color List' },
        })
        -- Other commands require color parameters, call them from the command mode
        -- :Colortils picker <color>
        -- :Colortils lighten <color>
        -- :Colortils darken <color>
        -- :Colortils greyscale <color>
        -- :Colortils gradient <color1> <color2>
    end
}
