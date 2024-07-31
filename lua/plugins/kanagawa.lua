return {
    'rebelot/kanagawa.nvim',
    'sho-87/kanagawa-paper.nvim',
    lazy = false,
    config = function()
        require('kanagawa').setup({
            transparent = true,
            theme = 'default',
            compile = true, -- Run :KanagawaCompile when applying changes
        })
        require('kanagawa-paper').setup({
            transparent = true,
            theme = 'default',
        })
    end
}
