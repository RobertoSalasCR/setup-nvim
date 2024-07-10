return {
    -- Peek Markdown Preview needs Deno to be installed
    'toppair/peek.nvim',
    event = 'VeryLazy',
    build = 'deno task --quiet build:fast',
    config = function()
        require('peek').setup({})
        local peek = require('peek')
        local wk = require('which-key')
        vim.api.nvim_create_user_command('PeekOpen', peek.open, {})
        vim.api.nvim_create_user_command('PeekClose', peek.close, {})
        -- which-Key Bindings
        wk.register({
            p = {
                name = 'Markdown Preview',
                c = { mode = { 'n' }, '<cmd>PeekClose<cr>', 'Peek Close' },
                o = { mode = { 'n' }, '<cmd>PeekOpen<cr>', 'Peek Open' },
            },
        }, { prefix = '<leader>' })
    end
}
