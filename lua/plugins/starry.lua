return {
    'ray-x/starry.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        require('starry').setup({
            border = true,
            hide_eob = true,
            italics = {
                comments = true,
                strings = true,
                keywords = false,
                funcions = false,
                variables = true,
            },
            disable = {
                background = false,
                term_colors = true,
                eob_lines = true,
            },
            contrast = {
                enable = true,
                terminal = true,
                filetypes = {},
            },
        })
    end
}
