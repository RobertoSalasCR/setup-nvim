
return {
    'ntk148v/komau.vim',
    lazy = false,
    priority = 1000,
    config = function()
        require('komau').setup({
            style = 'auto',
            transparent = true,
            terminal_colors = true,
            styles = {
                comments = { italic = true },
                keywords = { bold = true },
            },
        })
    end
}
