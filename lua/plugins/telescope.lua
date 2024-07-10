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
        local previewers = require('telescope.previewers')
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
                l = { mode = { 'n' }, builtin.builtin, 'Builtin List' },
                m = { mode = { 'n' }, builtin.marks, 'Marks' },
                n = { mode = { 'n' }, '<cmd>Noice pick<cr>', 'Noice Messages' },
                r = { mode = { 'n' }, builtin.registers, 'Registers' },
                s = { mode = { 'n' }, builtin.search_history, 'Search History' },
                ['?'] = { mode = { 'n' }, '<cmd>help telescope<cr>', 'Help' },
            },
        }, { prefix = '<leader>' })
    end
}
