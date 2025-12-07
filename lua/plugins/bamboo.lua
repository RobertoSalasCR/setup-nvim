return {
    'ribru17/bamboo.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        require('bamboo').setup({
            style = 'vulgaris',
            toggle_style_key = nil,
            toggle_style_list = { 'vulgaris', 'multiplex', 'light' },
            transparent = false,
            dim_inactive = true,
            code_style = {
                comments = { bold = false, italic = true },
                conditionals = { bold = true, italic = false },
                keywords = { bold = false, italic = true },
                functions = { bold = true, italic = false },
                namespaces = { bold = true, italic = false },
                parameters = { bold = true, italic = true },
                strings = { bold = false, italic = true },
                variables = { bold = true, italic = false },
            },
            lualine = {
                transparent = false,
            },
        })
    end
}
