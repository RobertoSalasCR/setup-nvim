return {
    'diegoulloao/neofusion.nvim',
    lazy = false,
    config = function()
        require('neofusion').setup({
            transparent_mode = true,
        })
    end
}
