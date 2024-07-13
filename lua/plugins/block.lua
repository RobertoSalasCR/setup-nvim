return {
    'HampusHauffman/block.nvim',
    config = function()
        local wk = require('which-key')
        require('block').setup({
            automatic = false,
        })
        wk.add({
            { '<leader>cb', '<cmd>Block<cr>', desc = 'Toggle Block' },
        })
    end
}
