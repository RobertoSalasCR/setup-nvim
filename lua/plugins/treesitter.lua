return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').setup({
      ensure_installed = {
        'lua','vim','vimdoc','javascript','json','html','css','styled',
        'go','gomod','gosum','gotmpl','gowork','templ','proto',
        'markdown','mermaid','toml','odin','rust','elixir','pascal',
        'zig','nim','nim_format_string','python','c_sharp','fsharp',
        'fortran','regex','bash', 'c', 'cpp',
      },
      ignore_install = { 'org' },
      auto_install = true,
      highlight = {
        enable = true,
        disable = { 'org' },
        additional_vim_regex_highlighting = false, -- mejor false con TS
      },
      incremental_selection = { enable = true },
      textobjects = { enable = true },
    })
 end
}

