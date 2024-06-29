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
                relativenumber = true,
                preserve_window_proportions = false,
            },
            actions = {
                open_file = { quit_on_open = true },
            },
        })

        -- Which-Key Bindings
        local wk = require('which-key')
        wk.register({
            e = {
                name = 'NvimTree File Explorer',
                -- g? to get mappings
                c = { mode = { 'n' }, '<cmd>NvimTreeCollapse<cr>', 'Collapse' },
                C = { mode = { 'n' }, '<cmd>NvimTreeClipboard<cr>', 'Clipboard' },
                e = { mode = { 'n' }, '<cmd>NvimTreeToggle<cr>', 'Toggle' },
                f = { mode = { 'n' }, '<cmd>NvimTreeFocus<cr>', 'Focus' },
                r = { mode = { 'n' }, '<cmd>NvimTreeRefresh<cr>', 'Refresh' },
                s = { mode = { 'n' }, '<cmd>NvimTreeFindFileToggle!<cr>', 'Search File' },
            },
        }, { prefix = '<leader>' })
    end
}
