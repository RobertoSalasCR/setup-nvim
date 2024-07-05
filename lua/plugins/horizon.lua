return {
    'akinsho/horizon.nvim',
    version = '*',
    config = function()
        require('horizon').setup({
            opts = {
                plugins = {
                    cmp = true,
                    telescope = true,
                    which_key = true,
                    barbar = true,
                    notify = true,
                    gitsigns = true,
                    flash = true,
                }
            }
        })
    end
}
