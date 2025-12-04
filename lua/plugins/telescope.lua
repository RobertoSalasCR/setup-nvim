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
        require('notify').setup({ background_colour = '#000000' })
        require('noice').setup({})
        require('telescope').load_extension('noice')
        require('telescope').setup({
            pickers = {
                colorscheme = {
                    theme = 'dropdown',
                },
                registers = {
                    theme = 'dropdown',
                    enable_preview = true,
                },
                search_history = {
                    theme = 'dropdown',
                },
            },
        })
        wk.add({
            { '<leader>t',  group = 'Telescope' },
            { '<leader>tb', builtin.buffers,        desc = 'Buffers' },
            { '<leader>tc', builtin.colorscheme,    desc = 'Colorscheme' },
            { '<leader>tf', builtin.find_files,     desc = 'Find Files' },
            { '<leader>tg', builtin.live_grep,      desc = 'Grep' },
            { '<leader>th', builtin.help_tags,      desc = 'Help Tags' },
            { '<leader>tm', builtin.marks,          desc = 'Marks' },
            { '<leader>tn', '<cmd>Noice pick<cr>',  desc = 'Noice Messages' },
            { '<leader>tr', builtin.registers,      desc = 'Registers' },
            { '<leader>ts', builtin.search_history, desc = 'Search History' },
            { '<leader>tt', builtin.treesitter,     desc = 'Treesitter' },
        })
    end
}
