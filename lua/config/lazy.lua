-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- import your plugins
        { import = "plugins" },
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "horizon" } },
    -- automatically check for plugin updates
    checker = { enabled = true },

})

local wk = require('which-key')
-- Which-Key Bindings
wk.add({
    { '<leader>l',  group = 'Lazy' },
    { '<leader>lo', '<cmd>Lazy show<cr>',    desc = 'Open' },
    { '<leader>lu', '<cmd>Lazy update<cr>',  desc = 'Update' },
    { '<leader>ls', '<cmd>Lazy sync<cr>',    desc = 'Sync' },
    { '<leader>ll', '<cmd>Lazy log<cr>',     desc = 'Log' },
    { '<leader>lr', '<cmd>Lazy restore<cr>', desc = 'Restore' },
})

-- Colorscheme
vim.cmd('colorscheme gruvbox')

-- Comment next code if you don't want transparency

-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })


