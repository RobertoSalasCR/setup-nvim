return {
    'nvim-telescope/telescope.nvim',
    event = 'VeryLazy',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'folke/noice.nvim',
        'rcarriga/nvim-notify',
    },
    config = function()
        local wk = require('which-key')
        local builtin = require('telescope.builtin')
        require('noice').setup({})
        require('telescope').load_extension('noice')
        wk.register({
            f = {
                name = 'Telescope',
                b = { mode = { 'n' }, builtin.buffers, 'Buffers' },
                c = { mode = { 'n' }, builtin.colorscheme, 'Colorscheme' },
                f = { mode = { 'n' }, builtin.find_files, 'Find Files' },
                g = { mode = { 'n' }, builtin.live_grep, 'Live Grep' },
                h = { mode = { 'n' }, builtin.help_tags, 'Help Tags' },
                n = { mode = { 'n' }, '<cmd>Noice pick<cr>', 'Noice Messages' },
                ['?'] = { mode = { 'n' }, '<cmd>help telescope<cr>', 'Help' },
            },
        }, { prefix = '<leader>' })
    end
}
