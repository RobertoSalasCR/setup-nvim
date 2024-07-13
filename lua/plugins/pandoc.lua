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
        wk.add({
            { '<leader>pe', '<cmd>PandocBuild<cr>', desc = 'Export' },
        })
    end
}
