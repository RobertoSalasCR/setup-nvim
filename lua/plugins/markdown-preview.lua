return {
    'iamcco/markdown-preview.nvim',
    event = 'VeryLazy',
    cmd = {
        'MarkdownPreviewToggle',
        'MarkdownPreview',
        'MarkdownPreviewStop',
    },
    ft = 'markdown',
    build = function()
        vim.fn['mkdp#util#install']()
    end,
    config = function()
        local wk = require('which-key')

        -- which-key bindings
        wk.register({
            p = {
                name = 'Preview Markdown',
                p = { mode = { 'n' }, '<cmd>MarkdownPreview<cr>', 'Browser Preview' },
                s = { mode = { 'n' }, '<cmd>MarkdownPreviewStop<cr>', 'Browser Stop' },
                t = { mode = { 'n' }, '<cmd>MarkdownPreviewToggle<cr>', 'Browser Toggle' },
            },
        }, { prefix = '<leader>' })
    end
}
