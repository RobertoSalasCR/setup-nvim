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
            { '<leader>f',   group = 'File' },
            { '<leader>fs',  '<cmd>w<cr>',                  desc = 'Save' },
            { '<leader>fq',  '<cmd>q<cr>',                  desc = 'Quit' },
            { '<leader>fe',  '<cmd>wq<cr>',                 desc = 'Save & Quit' },
            { '<leader>fS',  '<cmd>w!<cr>',                 desc = 'Force Save' },
            { '<leader>fQ',  '<cmd>q!<cr>',                 desc = 'Force Quit' },
            { '<leader>g',   group = 'LazyGit' },
            { '<leader>go',  '<cmd>LazyGit<cr>',            desc = 'Open All' },
            { '<leader>gl',  '<cmd>LazyGitLog<cr>',         desc = 'Log' },
            { '<leader>gc',  '<cmd>LazyGitCurrentFile<cr>', desc = 'Current File' },
            { '<leader>w',   group = 'Window' },
            { '<leader>wc',  '<c-w><c-q>',                  desc = 'Close' },
            { '<leader>wk',  '<c-w><c-k>',                  desc = 'Move Cursor Up' },
            { '<leader>wj',  '<c-w><c-j>',                  desc = 'Move Cursor Down' },
            { '<leader>wl',  '<c-w><c-l>',                  desc = 'Move Cursor Right' },
            { '<leader>wh',  '<c-w><c-h>',                  desc = 'Move Cursor LLeft' },
            { '<leader>ws',  group = 'Splits' },
            { '<leader>wsh', '<c-w>s',                      desc = 'Horizontal' },
            { '<leader>wsv', '<c-w>v',                      desc = 'Vertical' },
            { '<leader>wse', '<c-w>=',                      desc = 'Equal Size' },
            { '<leader>r',   group = 'Record State' },
            { '<leader>rs',  '<cmd>mkview<cr>',             desc = 'Save' },
            { '<leader>rl',  '<cmd>loadview<cr>',           desc = 'Load' },
            { '<leader>T',   '<cmd>Themery<cr>',            desc = 'Themery' },
        })
    end
}
