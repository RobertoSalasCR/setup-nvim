local opt = vim.opt
local g = vim.g
local cmd = vim.cmd

---------------------------------------------
--- General
---------------------------------------------
opt.mouse = 'a'
opt.clipboard = 'unnamedplus'
opt.swapfile = false
opt.completeopt = 'menuone,noinsert,noselect'

---------------------------------------------
--- Neovim UI
---------------------------------------------
opt.number = true
opt.relativenumber = true
opt.showmatch = true
opt.foldmethod = 'manual'
opt.foldcolumn = '1'
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true
opt.colorcolumn = '160'
opt.splitright = true
opt.splitbelow = true
opt.linebreak = true
opt.wrap = false
opt.termguicolors = true
opt.background = 'dark'
opt.laststatus = 3

---------------------------------------------
--- Tabs & Indent
---------------------------------------------
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.smartindent = true

---------------------------------------------
--- Memory & CPU
---------------------------------------------
opt.hidden = true
opt.history = 100
opt.lazyredraw = false
opt.synmaxcol = 240
opt.updatetime = 250

---------------------------------------------
--- Globals
---------------------------------------------
g.loaded_newtr = 1
g.loaded_newtrPlugin = 1

---------------------------------------------
--- Startup
---------------------------------------------
local disabled_built_ins = {
    "2html_plugin",
    "getscript",
    "getscriptPlugin",
    "gzip",
    "logipat",
    "newtrw",
    "newtrwPlugin",
    "newtrwSettings",
    "newtrwFileHandlers",
    "matchit",
    "tar",
    "tarPlugin",
    "rrhelper",
    "spellfile_plugin",
    "vimball",
    "vimballPlugin",
    "zip",
    "zipPlugin",
    "tutor",
    "rPlugin",
    "synmenu",
    "optwin",
    "compiler",
    "bugreport",
    "ftplugin"
}

for _, plugin in pairs(disabled_built_ins) do
    g["loaded_" .. plugin] = 1
end

require('config.lazy')
