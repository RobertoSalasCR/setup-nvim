return {
    'williamboman/mason.nvim',
    config = function()
        require("mason").setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        })

        -- Which-Key Bindings
        local wk = require('which-key')
        wk.add({
            { '<leader>m',  group = 'Mason' },
            { '<leader>mo', '<cmd>Mason<cr>',       desc = 'Open' },
            { '<leader>mu', '<cmd>MasonUpdate<cr>', desc = 'Update' },
            { '<leader>ml', '<cmd>MasonLog<cr>',    desc = 'Log' },
        })
    end
}
