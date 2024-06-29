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
        wk.register({
            b = {
                name = 'Buffer',
                ['?'] = { mode = { 'n' }, '<cmd>help barbar<cr>', 'Help' },
                ['.'] = { mode = { 'n' }, '<cmd>BufferNext<cr>', 'Next' },
                [','] = { mode = { 'n' }, '<cmd>BufferPrevious<cr>', 'Prev' },
                m = {
                    name = 'Move',
                    n = { mode = { 'n' }, '<cmd>BufferMoveNext<cr>', 'To Next Position' },
                    p = { mode = { 'n' }, '<cmd>BufferMovePrevious<cr>', 'To Prev Position' },
                },
                g = {
                    name = 'GoTo',
                    ['1'] = { mode = { 'n' }, '<cmd>BufferGoto 1<cr>', 'Goto 1' },
                    ['2'] = { mode = { 'n' }, '<cmd>BufferGoto 2<cr>', 'Goto 2' },
                    ['3'] = { mode = { 'n' }, '<cmd>BufferGoto 3<cr>', 'Goto 3' },
                    ['4'] = { mode = { 'n' }, '<cmd>BufferGoto 4<cr>', 'Goto 4' },
                    ['5'] = { mode = { 'n' }, '<cmd>BufferGoto 5<cr>', 'Goto 5' },
                    ['6'] = { mode = { 'n' }, '<cmd>BufferGoto 6<cr>', 'Goto 6' },
                    ['7'] = { mode = { 'n' }, '<cmd>BufferGoto 7<cr>', 'Goto 7' },
                    ['8'] = { mode = { 'n' }, '<cmd>BufferGoto 8<cr>', 'Goto 8' },
                    ['9'] = { mode = { 'n' }, '<cmd>BufferGoto 9<cr>', 'Goto 9' },
                },
                P = { mode = { 'n' }, '<cmd>BufferPin<cr>', 'Pin' },
                p = {
                    name = 'Magic Picking',
                    p = { mode = { 'n' }, '<cmd>BufferPick<cr>', 'Pick' },
                    d = { mode = { 'n' }, '<cmd>BufferPickDelete<cr>', 'Pick Delete' },
                },
                c = {
                    name = 'Close',
                    a = { mode = { 'n' }, '<cmd>BufferCloseAllButCurrent<cr>', 'All Except Current' },
                    c = { mode = { 'n' }, '<cmd>BufferClose<cr>', 'Current' },
                    l = { mode = { 'n' }, '<cmd>BufferCloseBuffersLeft<cr>', 'All To The Left' },
                    o = { mode = { 'n' }, '<cmd>BufferCloseAllButCurrentOrPinned<cr>', 'All Except Current Or Pinned' },
                    p = { mode = { 'n' }, '<cmd>BufferCloseAllButPinned<cr>', 'All Except Pinned' },
                    r = { mode = { 'n' }, '<cmd>BufferCloseBuffersRight<cr>', 'All To The Right' },
                    v = { mode = { 'n' }, '<cmd>BufferCloseAllButVisible<cr>', 'All Except Visible' },
                },
                s = {
                    name = 'Sort',
                    d = { mode = { 'n' }, '<cmd>BufferOrderByDirectory<cr>', 'By Directory' },
                    l = { mode = { 'n' }, '<cmd>BufferOrderByLanguage<cr>', 'By Language' },
                    N = { mode = { 'n' }, '<cmd>BufferOrderByBufferNumber<cr>', 'By Number' },
                    n = { mode = { 'n' }, '<cmd>BufferOrderByName<cr>', 'By Name' },
                    w = { mode = { 'n' }, '<cmd>BufferOrderByWindowNumber<cr>', 'By Window Number' }
                },
                w = { mode = { 'n' }, '<cmd>BufferWipeout<cr>', 'Wipeout' },
                b = { mode = { 'n' }, '<cmd>BarbarEnable<cr>', 'Barbar Toggle' },
            },
        }, { prefix = '<leader>' })
    end
}
