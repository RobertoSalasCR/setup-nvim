return {
    'Tsuzat/NeoSolarized.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        require("NeoSolarized").setup({
            style = 'dark',
            transparent = true,
            enable_italics = true,
            styles = { comments = { italic = true }, keywords = { bold = true } }
        })
    end
}
