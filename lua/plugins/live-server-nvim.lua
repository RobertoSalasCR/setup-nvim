return {
    'ngtuonghy/live-server-nvim',
    event = 'VeryLazy',
    build = ':LiveServerInstall',
    config = function()
        require('live-server-nvim').setup({})

        -- Which-Key Bindings
        local wk = require('which-key')
        wk.add({
            { '<leader>cs', '<cmd>LiveServerToggle<cr>', desc = 'Live Server' },
        })
    end
}
