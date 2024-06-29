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
        wk.register({
            m = {
                name = 'Mason',
                o = { mode = { 'n' }, '<cmd>Mason<cr>', 'Open/Show' },
                u = { mode = { 'n' }, '<cmd>MasonUpdate<cr>', 'Update' },
                l = { mode = { 'n' }, '<cmd>MasonLog<cr>', 'Log' },
                ['?'] = { mode = { 'n' }, '<cmd>help mason<cr>', 'Help' },
            },
        }, { prefix = '<leader>' })
    end
}
