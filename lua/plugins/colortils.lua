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
        wk.register({
            c = {
                name = 'Code',
                p = {
                    name = 'Pickers',
                    c = { mode = { 'n' }, '<cmd>Colortils css list<cr>', 'CSS Color List' },
                }
            }
        }, { prefix = '<leader>' })
        -- Other commands require color parameters, call them from the command mode
        -- :Colortils picker <color>
        -- :Colortils lighten <color>
        -- :Colortils darken <color>
        -- :Colortils greyscale <color>
        -- :Colortils gradient <color1> <color2>
    end
}
