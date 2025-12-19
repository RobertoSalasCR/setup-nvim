return {
    'B4mbus/oxocarbon-lua.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        vim.g.oxocarbon_lua_transparent = true
        vim.g.oxocarbon_lua_alternative_telescope = true
    end
}
