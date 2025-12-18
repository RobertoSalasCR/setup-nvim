return {
  'mrcjkb/rustaceanvim',
  version = '^6', -- Recommended
  lazy = false,   -- This plugin is already lazy
  config = function()
    -- Configuración global de rustaceanvim (solo LSP; DAP lo lleva nvim-dap)
    vim.g.rustaceanvim = {
      server = {
        default_settings = {
          ['rust-analyzer'] = {
            checkOnSave = {
              command = 'clippy',
              extraArgs = { '--no-deps' },
            },
            procMacro = {
              enable = true,
            },
            inlayHints = {
              lifetimeElisionHints = { enable = 'always' },
              closureReturnTypeHints = { enable = 'always' },
            },
          },
        },
      },
      dap = {}, -- vacío, usamos nvim-dap manualmente
    }
  end,
}

