return {
    'aliqyan-21/darkvoid.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        require('darkvoid').setup({
            transparent = true,
            glow = true,
            show_end_of_buffer = true,
        })
    end
}
