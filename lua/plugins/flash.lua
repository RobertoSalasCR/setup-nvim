return {
    'folke/flash.nvim',
    config = function()
        require('flash').setup({})
        local flash = require('flash')
        local wk = require('which-key')
        wk.add({
            { '<leader>j', function() flash.jump() end, desc = 'Flash Jump', mode = { 'n', 'x', 'o' } },
        })
    end
}
