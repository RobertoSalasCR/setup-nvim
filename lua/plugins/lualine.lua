return {
    'nvim-lualine/lualine.nvim',
    config = function()
        require('lualine').setup({
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff' },
                lualine_c = {
                    'diagnostics',
                    sources = { 'nvim_lsp' },
                },
                lualine_x = { 'filetype', 'filesize', 'progress' },
                lualine_y = { 'encoding' },
                lualine_z = { 'datetime' },
            },
        })
    end
}
