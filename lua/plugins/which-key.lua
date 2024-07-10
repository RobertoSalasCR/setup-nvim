return {
    'folke/which-key.nvim',
    config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
        require('which-key').setup({})
        local wk = require('which-key')

        -- Which-Key Package Independent  Bindings
        wk.register({
            w = {
                name = 'Window',
                k = { mode = { 'n' }, '<c-w><c-k>', 'Move Cursor Up' },
                j = { mode = { 'n' }, '<c-w><c-j>', 'Move Cursor Down' },
                l = { mode = { 'n' }, '<c-w><c-l>', 'Move Cursor Right' },
                h = { mode = { 'n' }, '<c-w><c-h>', 'Move Cursor Left' },
                c = { mode = { 'n' }, '<c-w><c-q>', 'Close Window' },
                r = { mode = { 'n' }, '<c-w><c-r>', 'Rotate Position' },
                e = { mode = { 'n' }, '<c-w>=', 'Equal Size Splits' },
                s = {
                    name = 'Split',
                    h = { mode = { 'n' }, '<c-w>s', 'Split Horizontal' },
                    v = { mode = { 'n' }, '<c-w>v', 'Split Vertical' },
                },
            },
            ['?'] = { mode = { 'n' }, '<cmd>help which-key<cr>', 'Help' },
            r = {
                name = 'State Record',
                s = { mode = { 'n' }, '<cmd>mkview<cr>', 'Save' },
                l = { mode = { 'n' }, '<cmd>loadview<cr>', 'Load' },
            },
        }, { prefix = '<leader>' })
    end
}
