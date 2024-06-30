return {
    'nvim-lualine/lualine.nvim',
    config = function()
        require('lualine').setup({
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch' },
                lualine_c = { 'filename' },
                lualine_x = { 'filetype', 'filesize', 'progress' },
                lualine_y = { 'encoding' },
                lualine_z = { 'datetime' },
            },
        })
    end
}
