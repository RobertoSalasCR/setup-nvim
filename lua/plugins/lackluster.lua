return {
    'slugbyte/lackluster.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        require('lackluster').setup({
            tweak_bakcground = {
                normal = 'none',
                telescope = 'none',
                menu = 'default',
                popup = 'default',
            },
        })
    end
}
