return {
    'catppuccin/nvim',
    name = 'catppuccin',
    config = function()
        require('catppuccin').setup({
            flavour = 'mocha', -- latte, frappe, macchiato, mocha
            background = {
                light = 'latte',
                dark = 'mocha'
            },
            transparent_background = true,
            show_end_of_buffer = false, -- shows the ~ characters
            no_italic = false,          -- Force no italic
            no_bold = false,            -- Force no bold
            no_underline = false,       -- Force no underline
            styles = {                  -- Handles the styles of general hi groups (see `:h highlight-args`):
                comments = {},          -- Change the style of comments
                conditionals = {},
                loops = {},
                functions = { 'bold', 'italic' },
                keywords = {},
                strings = {},
                variables = { 'underline' },
                numbers = {},
                booleans = {},
                properties = {},
                types = {},
                operators = { 'bold' },
                -- miscs = {}, -- Uncomment to turn off hard-coded styles
            },
            -- integrations = {
            --     cmp = true,
            --     gitsigns = true,
            --     nvimtree = true,
            --     treesitter = true,
            --     notify = true,
            --     flash = true,
            --     barbar = true,
            --     which_key = true,
            --     telescope = true,
            -- },
        })
    end
}
