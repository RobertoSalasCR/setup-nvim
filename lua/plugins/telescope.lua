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
        wk.add({
            { '<leader>f',  group = 'Telescope' },
            { '<leader>fb', builtin.buffers,        desc = 'Buffers' },
            { '<leader>fc', builtin.colorscheme,    desc = 'Colorscheme' },
            { '<leader>ff', builtin.find_files,     desc = 'Find Files' },
            { '<leader>fg', builtin.live_grep,      desc = 'Live Grep' },
            { '<leader>fh', builtin.help_tags,      desc = 'Help Tags' },
            { '<leader>fm', builtin.marks,          desc = 'Marks' },
            { '<leader>fn', '<cmd>Noice pick<cr>',  desc = 'Noice Messages' },
            { '<leader>fr', builtin.registers,      desc = 'Registers' },
            { '<leader>fs', builtin.search_history, desc = 'Search History' },
        })
    end
}
