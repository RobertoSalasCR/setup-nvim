return {
    'folke/tokyonight.nvim',
    config = function()
        -- Flavours night, storm, day, moon
        require('tokyonight').setup({
            transparent = true,
            plugins = {
                auto = true,
            },
        })
    end
}
