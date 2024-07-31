return {
    'NTBBloodbath/sweetie.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        local g = vim.g
        g.sweetie = {
            pumblend = {
                enable = true,
                transparency_amount = 20,
            },
        }
    end
}
