return {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require('gruvbox').setup({
            transparent_mode = false,
            bold = false,
            underline = true,
            inverse = true,
            invert_selection = false,
            dim_inactive = false,
            strikethrough = true,
            contrast = 'hard',
            italic = {
                strings = true,
                emphasis = false,
                comments = true,
                operators = false,
                folds = false,
            },
        })
    end
}
