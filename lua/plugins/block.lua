return {
    'HampusHauffman/block.nvim',
    config = function()
        local wk = require('which-key')
        require('block').setup({
            automatic = false,
        })
        wk.register({
            c = {
                name = 'Code',
                b = { mode = { 'n' }, '<cmd>Block<cr>', 'Toggle Block' },
            },
        }, { prefix = '<leader>' })
    end
}
