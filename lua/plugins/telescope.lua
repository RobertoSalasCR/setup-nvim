return {
    'nvim-telescope/telescope.nvim',
    event = 'VeryLazy',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'folke/noice.nvim',
        'MunifTanjim/nui.nvim',
        'rcarriga/nvim-notify',
    },
    config = function()
        local wk = require('which-key')
        local builtin = require('telescope.builtin')
        require('noice').setup({})
        require('telescope').load_extension('noice')
        require('telescope').load_extension('lazygit')
        wk.register({
            f = {
                name = 'Telescope',
                b = { mode = { 'n' }, builtin.buffers, 'Buffers' },
                f = { mode = { 'n' }, builtin.find_files, 'Find Files' },
                g = { mode = { 'n' }, builtin.live_grep, 'Live Grep' },
                h = { mode = { 'n' }, builtin.help_tags, 'Help Tags' },
                l = { mode = { 'n' }, '<cmd>Telescope lazygit<cr>', 'LazyGit Repos' },
                n = { mode = { 'n' }, '<cmd>Noice pick<cr>', 'Noice Messages' },
                ['?'] = { mode = { 'n' }, '<cmd>help telescope<cr>', 'Help' },
            },
        }, { prefix = '<leader>' })
    end
}
