return {
    'folke/flash.nvim',
    config = function()
        require('flash').setup({})
        local flash = require('flash')
        local wk = require('which-key')
        wk.add({
            { '<leader>j', function() flash.jump() end, desc = 'Jump - Flash Easy Motion', mode = { 'n', 'x', 'o' } },
        })
    end
}
