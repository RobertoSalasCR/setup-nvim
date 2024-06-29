return {
    'folke/flash.nvim',
    config = function()
        require('flash').setup({})
        local flash = require('flash')
        local wk = require('which-key')
        wk.register({
            s = {
                name = 'Flash Easy Motion',
                s = { mode = { 'n', 'x', 'o' }, function() flash.jump() end, 'Flash Jump' },
                S = { mode = { 'n', 'x', 'o' }, function() flash.treesitter() end, 'Flash Treesitter' },
                r = { mode = { 'o' }, function() flash.remote() end, 'Remote Flash' },
                R = { mode = { 'o', 'x' }, function() flash.treesitter_search() end, 'Treesitter Search' },
            }
        }, { prefix = '<leader>' })
    end
}
