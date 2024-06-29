return {
    'stevearc/oil.nvim',
    config = function()
        require('oil').setup({
            columns = {
                'icon',
            },
            buf_options = {
                buflisted = true,
                bufhidden = 'hide',
            },
            view_options = {
                show_hidden = true,
                is_hidden_file = function(name, _)
                    return vim.startswith(name, '.')
                end,
                is_always_hidden = function()
                    return false
                end,
                natural_order = true,
                sort = {
                    { 'type', 'asc' },
                    { 'name', 'asc' },
                },
            },
            lsp_file_methods = {
                timeout_ms = 2000,
                autosave_changes = true,
            },
            skip_confirm_for_simple_edits = false,
            prompt_save_on_select_new_entry = true,
            delete_to_trash = true,
        })
        local wk = require('which-key')
        wk.register({
            o = { mode = { 'n' }, '<cmd>Oil --float<cr>', 'Oil File Explorer' }
        }, { prefix = '<leader>' })
    end
}
