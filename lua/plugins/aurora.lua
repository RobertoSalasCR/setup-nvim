return {
    'ray-x/aurora',
    lazy = false,
    priority = 1000,
    config = function()
        local g = vim.g
        -- g.aurora_darker = 1
        vim.g.aurora_transparent = 1
        vim.g.aurora_italic = 1
        vim.g.aurora_bold = 1
    end
}
