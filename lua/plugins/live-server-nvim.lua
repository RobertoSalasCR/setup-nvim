return {
    'ngtuonghy/live-server-nvim',
    event = 'VeryLazy',
    build = ':LiveServerInstall',
    config = function()
        require('live-server-nvim').setup({})
        -- Which-Key Bindings
        local wk = require('which-key')
        wk.register({
            c = {
                name = 'Code',
                s = { mode = { 'n' }, '<cmd>LiveServerToggle<cr>', 'Live Server' },
            },
        }, { prefix = '<leader>' })
    end
}
