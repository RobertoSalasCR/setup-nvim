return {
    'nvim-tree/nvim-tree.lua',
    event = 'VeryLazy',
    config = function()
        require('nvim-tree').setup({
            hijack_cursor = true,
            diagnostics = { enable = true },
            modified = { enable = true },
            reload_on_bufenter = true,
            select_prompts = true,
            view = {
                relativenumber = false,
                preserve_window_proportions = false,
            },
            actions = {
                open_file = { quit_on_open = false },
            },
        })

        -- Which-Key Bindings
        local wk = require('which-key')
        wk.add({
            { '<leader>e',  group = 'Explorer' },
            { '<leader>ec', '<cmd>NvimTreeCollapse<cr>',       desc = 'Collapse' },
            { '<leader>ee', '<cmd>NvimTreeToggle<cr>',         desc = 'Toggle' },
            { '<leader>ef', '<cmd>NvimTreeFocus<cr>',          desc = 'Focus' },
            { '<leader>er', '<cmd>NvimTreeRefresh<cr>',        desc = 'Refresh' },
            { '<leader>es', '<cmd>NvimTreeFindFileToggle<cr>', desc = 'Search File' },
        })
    end
}
