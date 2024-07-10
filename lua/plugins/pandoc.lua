return {
    'aspeddro/pandoc.nvim',
    config = function()
        require('pandoc').setup({
            commands = {
                name = 'PandocBuild',
            },
            default = {
                output = '%s.html',
            },
        })
        -- which-Key Bindings
        local wk = require('which-key')
        local render = require('pandoc.render')
        wk.register({
            p = {
                name = 'Markdown Preview',
                e = { mode = { 'n' }, '<cmd>PandocBuild<cr>', 'Export' },
            }
        }, { prefix = '<leader>' })
    end
}
