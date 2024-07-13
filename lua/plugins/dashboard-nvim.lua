return {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
        local wk = require('which-key')
        require('dashboard').setup({
            theme = 'hyper',
            hide = { 'statusline', 'tabline', 'winbar' },
            config = {
                week_header = { enable = true },
            },
        })

        wk.add({
            { '<leader>d', '<cmd>Dashboard<cr>', desc = 'Dashboard' },
        })
    end
}
