return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('lualine').setup({
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'diff', 'branch' },
                lualine_c = { 'filetype', 'filename', 'filesize' },
                lualine_x = { 'diagnostics', 'lsp_status' },
                lualine_y = { 'encoding' },
                lualine_z = { 'datetime' },
            },
        })
    end
}
