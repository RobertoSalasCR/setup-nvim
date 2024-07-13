return {
    'romgrk/barbar.nvim',
    dependencies = {
        'lewis6991/gitsigns.nvim',
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
        local wk = require('which-key')

        require('barbar').setup({})

        -- Which-Key Bindings
        wk.add({
            { '<leader>b',   group = 'Buffer' },
            { '<leader>bn',  '<cmd>BufferNext<cr>',                desc = 'Next' },
            { '<leader>bp',  '<cmd>BufferPrevious<cr>',            desc = 'Previous' },
            { '<leader>bg',  group = 'GoTo' },
            { '<leader>bg1', '<cmd>BufferGoto 1<cr>',              desc = '1' },
            { '<leader>bg2', '<cmd>BufferGoto 2<cr>',              desc = '2' },
            { '<leader>bg3', '<cmd>BufferGoto 3<cr>',              desc = '3' },
            { '<leader>bg4', '<cmd>BufferGoto 4<cr>',              desc = '4' },
            { '<leader>bg5', '<cmd>BufferGoto 5<cr>',              desc = '5' },
            { '<leader>bg6', '<cmd>BufferGoto 6<cr>',              desc = '6' },
            { '<leader>bg7', '<cmd>BufferGoto 7<cr>',              desc = '7' },
            { '<leader>bg8', '<cmd>BufferGoto 8<cr>',              desc = '8' },
            { '<leader>bg9', '<cmd>BufferGoto 9<cr>',              desc = '9' },
            { '<leader>bP',  '<cmd>BufferPin<cr>',                 desc = 'Pin' },
            { '<leader>bm',  group = 'Magic Picking' },
            { '<leader>bmp', '<cmd>BufferPick<cr>',                desc = 'Pick' },
            { '<leader>bmd', '<cmd>BufferPickDelete<cr>',          desc = 'Delete Pick' },
            { '<leader>bc',  '<cmd>BufferClose<cr>',               desc = 'Close' },
            { '<leader>bC',  group = 'Other Closing Options' },
            { '<leader>bCa', '<cmd>BufferCloseAllButCurrent<cr>',  desc = 'All Except Current' },
            { '<leader>bCl', '<cmd>BufferCloseBuffersLeft<cr>',    desc = 'All To The Left' },
            { '<leader>bCr', '<cmd>BufferCloseBuffersRight<cr>',   desc = 'All To The Right' },
            { '<leader>bCp', '<cmd>BufferCloseAllButPinned<cr>',   desc = 'All Except Pinned' },
            { '<leader>bCv', '<cmd>BufferCloseAllButVisible<cr>',  desc = 'All Except Visible' },
            { '<leader>bs',  group = 'Sort' },
            { '<leader>bsd', '<cmd>BufferOrderByDirectory<cr>',    desc = 'By Directory' },
            { '<leader>bsl', '<cmd>BufferOrderByLanguage<cr>',     desc = 'By Language' },
            { '<leader>bsn', '<cmd>BufferOrderByName<cr>',         desc = 'By Name' },
            { '<leader>bsu', '<cmd>BufferOrderByWindowNumber<cr>', desc = 'By Number' },
            { '<leader>bw',  '<cmd>BufferWipeout<cr>',             desc = 'Wipeout' },
            { '<leader>bb',  '<cmd>BarbarEnable<cr>',              desc = 'Barbar Toggle' },
        })
    end
}
