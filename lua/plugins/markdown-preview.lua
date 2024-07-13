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
        wk.add({
            { '<leader>p',  group = 'Markdown' },
            { '<leader>pp', '<cmd>MarkdownPreviewToggle<cr>', desc = 'Preview In Browser' },
        })
    end
}
