return {
    'iruzo/matrix-nvim',
    lazy = false,
    priority = 1000,
    config = function()
        vim.g.matrix_contrast = true
        vim.g.matrix_borders = false
        vim.g.matrix_disable_background = true
        vim.g.matrix_italic = true
    end
}
