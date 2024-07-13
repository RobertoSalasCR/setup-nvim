return {
    'folke/which-key.nvim',
    dependencies = {
        'echasnovski/mini.icons',
        version = false,
    },
    config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
        require('mini.icons').setup({})
        require('which-key').setup({})
        local wk = require('which-key')

        -- Which-Key Package Independent  Bindings
        wk.add({
            { '<leader>w',        group = 'Window' },
            { '<leader>wc',       '<c-w><c-q>',          desc = 'Close' },
            { '<leader>wk',       '<c-w><c-k>',          desc = 'Move Cursor Up' },
            { '<leader>wj',       '<c-w><c-j>',          desc = 'Move Cursor Down' },
            { '<leader>wl',       '<c-w><c-l>',          desc = 'Move Cursor Right' },
            { '<leader>wh',       '<c-w><c-h>',          desc = 'Move Cursor LLeft' },
            { '<leader>ws',       group = 'Splits' },
            { '<leader>wsh',      '<c-w>s',              desc = 'Horizontal' },
            { '<leader>wsv',      '<c-w>v',              desc = 'Vertical' },
            { '<leader>wse',      '<c-w>=',              desc = 'Equal Size' },
            { '<leader>r',        group = 'Record State' },
            { '<leader>rs',       '<cmd>mkview<cr>',     desc = 'Save' },
            { '<leader>rl',       '<cmd>loadview<cr>',   desc = 'Load' },
        })
    end
}
