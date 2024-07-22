return {
    'Mofiqul/adwaita.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        local opt = vim.opt
        local g = vim.g
        g.adwaita_darker = true
        g.adwaita_transparent = true
    end
}
