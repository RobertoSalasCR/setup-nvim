-- Este archivo define y activa la configuración LSP utilizando el API canónico
-- de Neovim 0.11+ (vim.lsp.config y vim.lsp.enable).

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'mrcjkb/rustaceanvim',  -- Rust moderno, reemplaza rust-tools.nvim
    'L3MON4D3/LuaSnip',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'saadparwaiz1/cmp_luasnip',
    'lukas-reineke/lsp-format.nvim',
    'nvimdev/lspsaga.nvim',
    'rafamadriz/friendly-snippets',
    'MarcHamamji/runner.nvim',
    'brenoprata10/nvim-highlight-colors',
    'MysticalDevil/inlay-hints.nvim',
  },
  config = function()
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    local lspsaga = require('lspsaga')
    local wk = require('which-key')
    local builtin = require('telescope.builtin')
    local lsp_format = require('lsp-format')
    local util = require('lspconfig.util')
    -- Importar el helper para ejecutar comandos de shell de forma segura
    local shell_handler = require('runner.handlers.helpers').shell_handler

    -- [[ 1. Definición de la función on_attach ]]
    local on_attach = function(client, bufnr)
      lsp_format.on_attach(client, bufnr) -- Autoformato si el servidor lo soporta

      if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_buf_set_option(
          bufnr,
          'formatexpr',
          'v:lua.vim.lsp.buf.format({async = true})'
        )
      end

      local map = vim.keymap.set
      local opts = { noremap = true, silent = true, buffer = bufnr }

      -- Keymaps de LSP
      map('n', 'gD', vim.lsp.buf.declaration, opts)
      map('n', 'gd', '<cmd>Lspsaga goto_definition<CR>', opts)
      map('n', 'gi', vim.lsp.buf.implementation, opts)
      map('n', 'gr', vim.lsp.buf.references, opts)
      map('n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts)
      map('n', '<C-k>', vim.lsp.buf.signature_help, opts)
      map('n', '<leader>rn', '<cmd>Lspsaga rename<CR>', opts)
      map('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>', opts)
      map('n', '<leader>lf', '<cmd>lua vim.lsp.buf.format()<CR>', opts)

      -- CORRECCIÓN: usar vim.diagnostic en lugar de vim.lsp.buf.diagnostic_*
      map('n', '[d', vim.diagnostic.goto_prev, opts)
      map('n', ']d', vim.diagnostic.goto_next, opts)
    end
    -- [ FIN DE 1. Definición de la función on_attach ]

    -- [[ 2. Definición de la Configuración Canónica de Servidores ]]
    local SERVER_CONFIGS = {

      -- Python
      pylyzer = {
          cmd = { 'pylyzer', '--server' },
          filetypes = { 'python' },
          settings = {
              python = {
                  inlayHints = true,
                  diagnostics = true,
                  smartCompletion = true,
                  checkOnType = false,
              },
          },
      },

      -- C Lang
      clangd = {
        cmd = { 'clangd' },
        filetypes = { 'c', 'cpp' },
        root_dir = function(fname)
          return util.root_pattern('clangd', 'clang-format', 'configure.ac')(fname)
        end,
      },

      -- Go (gopls)
      gopls = {
        cmd = { 'gopls' },
        -- filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
        -- root_dir = util.root_pattern('go.work', 'go.mod', '.git'),
        settings = {
          gopls = {
            semanticTokens = true,
            completeUnimported = true,
            usePlaceholders = true,
            gofumpt = true,
            staticcheck = true,
            analyses = {
              unusedparams = true,
            },
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              rangeVariableTypes = true,
            },
          },
        },
      },

      -- Templ
      templ = {
        cmd = { 'templ', 'lsp' },
        filetypes = { 'templ' },
        root_dir = util.root_pattern('go.work', 'go.mod', '.git'),
      },

      -- Fortran
      fortls = {
          cmd = { 
              'fortls',
              '--lowercase_intrinsics',
              '--hover_signature',
              '--hover_language=fortran',
              '--use_signature_help',
          },
      },

      -- Lua (lua_ls)
      lua_ls = {
        cmd = { 'lua-language-server' },
        filetypes = { 'lua' },
        root_dir = util.root_pattern(
          '.luarc.json',
          '.luarc.jsonc',
          '.luacheckrc',
          '.stylua.toml',
          'selene.toml',
          'selene.yml',
          '.git'
        ),
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim', 'it', 'describe', 'before_each', 'after_each' },
            },
            workspace = {
              library = {
                [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
              },
              maxPreload = 100000,
              checkThirdParty = false,
            },
            completion = {
              callSnippet = 'Replace',
              keywordSnippet = 'Replace',
            },
          },
        },
      },

      -- TypeScript/JavaScript (tsserver)
      tsserver = {
        cmd = { 'typescript-language-server', '--stdio' },
        filetypes = {
          'javascript',
          'javascriptreact',
          'javascript.jsx',
          'typescript',
          'typescriptreact',
          'typescript.tsx',
        },
        init_options = {
          hostInfo = 'neovim',
        },
        root_dir = util.root_pattern(
          'tsconfig.json',
          'jsconfig.json',
          'package.json',
          '.git'
        ),
      },

      -- Zig (zls)
      zls = {
        cmd = { 'zls' },
        filetypes = { 'zig' },
        root_dir = util.root_pattern('build.zig', '.git'),
        settings = {
          zls = {
            inlayHints = {
              paramNames = true,
              paramTypes = false,
              autofix = true,
            },
          },
        },
      },

      -- Odin (odinls)
      odinls = {
        cmd = { 'ols' },
        filetypes = { 'odin' },
        root_dir = util.root_pattern('build.odin', '.git'),
      },

      -- C3
      c3ls = {
        cmd = { 'c3lsp' },
        filetypes = { 'c3', 'c3i', 'c3t' },
        root_dir = util.root_pattern( '.git' ),
      },

      -- Elixir (elixirls)
      elixirls = {
        cmd = { 'elixir-ls' },
        filetypes = { 'elixir', 'eelixir', 'heex' },
        -- root_dir = util.root_pattern('mix.exs', '.git'),
        settings = {
          elixirLS = {
            dialyzerEnabled = false,
            enableTestLenses = true,
          },
        },
        -- Nota: on_attach especial para Elixir
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)

          vim.api.nvim_create_autocmd('BufEnter', {
            buffer = bufnr,
            callback = function()
              vim.lsp.codelens.refresh()
            end,
          })
        end,
      },

      -- Servidores simples
      html = {
        filetypes = { 'html', 'twig' },
      },
      cssls = {
        filetypes = { 'css', 'scss', 'less', 'sass' },
      },
      marksman = {
        filetypes = { 'markdown' },
      },
      markdown_oxide = {
        filetypes = { 'markdown' },
      },
    }

    -- [[ 3. Aplicar Configuración y Habilitación (vim.lsp.config & vim.lsp.enable) ]]
    for name, config in pairs(SERVER_CONFIGS) do
      -- 3a. Añadir opciones genéricas y on_attach
      config.capabilities = capabilities
      if not config.on_attach then
        config.on_attach = on_attach
      end

      -- 3b. Definir/Extender la configuración del servidor (vim.lsp.config)
      vim.lsp.config(name, config)

      -- 3c. Habilitar la configuración (vim.lsp.enable)
      vim.lsp.enable(name)
    end
    -- [ FIN DE 3. Aplicar Configuración ]

    -- [[ 4. rustaceanvim: configuración de Rust y rust-analyzer ]]
    vim.g.rustaceanvim = {
      server = {
        on_attach = on_attach,
        default_settings = {
          ['rust-analyzer'] = {
            checkOnSave = {
              command = 'clippy',
              extraArgs = { '--no-deps' },
            },
            procMacro = {
              enable = true,
            },
          },
        },
      },
    }

    -- Plugins de Soporte
    require('nvim-highlight-colors').setup({
      render = 'virtual',
      enable_hex = true,
      enable_short_hex = true,
      enable_rgb = true,
      enable_hsl = true,
      enable_var_usage = true,
      enable_named_colors = true,
      enable_tailwind = true,
    })

    require('inlay-hints').setup({
      commands = {
        enable = true,
      },
      autocmd = {
        enable = true,
      },
    })

    require('lsp-format').setup({})


    -- Runner: EJECUCIÓN MANUAL
    require('runner').setup({
      position = 'bot',
      size = 15,
      term_name = 'Runner',
      startinsert = false,
    })


    -- ============================================================================
    -- FUNCIÓN PARA EJECUTAR ARCHIVO ACTUAL (AUTO-DETECTA LENGUAJE)
    -- ============================================================================
    function RunCurrentFile()
      local ft = vim.bo.filetype
      local file = vim.fn.expand('%') -- Ruta relativa del archivo actual
      local bufnr = vim.api.nvim_get_current_buf() -- Obtener numero de buffer actual

      local commands = {
        zig = 'zig run ' .. file,
        odin = 'odin run ' .. file .. ' -file',
        go = 'go run ' .. file,
        rust = 'cargo run',
        python = 'python3 ' .. file,
        javascript = 'node ' .. file,
        typescript = 'ts-node ' .. file,
        lua = 'lua ' .. file,
        pascal = 'fpc ' .. file .. ' && ./' .. vim.fn.expand('%:r'),
        fortran = 'gfortran ' .. file .. ' -o ' .. vim.fn.expand('%:r') .. ' && ./' .. vim.fn.expand('%:r'),
        nim = 'nim compile --run ' .. file,
        c = 'clang ' .. file .. ' -o ' .. vim.fn.expand('%:r') .. ' && ./' .. vim.fn.expand('%:r'),
        cpp = 'clang ' .. file .. ' -o ' .. vim.fn.expand('%:r') .. ' && ./' .. vim.fn.expand('%:r'),
        c3 = 'c3c run', -- Compile a project not a single file
      }

      local cmd = commands[ft]

      if cmd then
        vim.cmd('Lspsaga term_toggle')
        vim.defer_fn(function()
          local keys = vim.api.nvim_replace_termcodes(cmd .. '<CR>', true, false, true)
          vim.api.nvim_feedkeys(keys, 't', false)
        end, 100)
      else
        print('No hay comando configurado para filetype: ' .. ft)
      end
    end

    -- Crear comando de usuario
    vim.api.nvim_create_user_command(
      'RunFile',
      RunCurrentFile,
      { desc = 'Ejecuta el archivo actual (auto-detecta lenguaje)' }
    )

    -- CMP & LuaSnip, Lspsaga, Which-Key
    local cmp = require('cmp')
    require('luasnip.loaders.from_vscode').lazy_load()
    local luasnip = require('luasnip')
    require('luasnip').setup({})

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      formatting = {
        format = require('nvim-highlight-colors').format,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }),
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.locally_jumpable() then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'cmdline' },
        { name = 'orgmode' },
      }),
    })

    cmp.setup.cmdline('/', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' },
      },
    })

    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'path' },
        { name = 'cmdline' },
      },
    })

    lspsaga.setup({
      lightbulb = {
        enable = false,
        sign = true,
        virtual_text = true,
        debounce = 10,
        sign_priority = 40,
      },
    })

    -- Which-Key Mappings
    wk.add({
      { '<leader>c', group = 'Code' },

      -- LSP General
      { '<leader>ca', '<cmd>Lspsaga code_action<CR>', desc = 'Code Action' },
      { '<leader>cd', '<cmd>Lspsaga goto_definition<CR>', desc = 'Goto Definition' },
      { '<leader>ch', '<cmd>Lspsaga hover_doc<CR>', desc = 'Hover Doc' },
      { '<leader>ci', '<cmd>InlayHintsToggle<CR>', desc = 'Toggle Inlay Hints' },
      { '<leader>co', '<cmd>Lspsaga outline<CR>', desc = 'Code Outline' },
      { '<leader>cw', '<cmd>Lspsaga rename<CR>', desc = 'Word Rename' },
      { '<leader>ct', '<cmd>Lspsaga term_toggle<cr>', desc = 'Terminal' },
      {
        '<leader>ce',
        '<cmd>Lspsaga show_buf_diagnostics<cr>',
        desc = 'Show Errors/Diagnostics',
      },

      -- Runner: ejecución manual
      { '<leader>cr', '<cmd>RunFile<cr>', desc = 'Run Current File' },
      { '<leader>cc', ':!rm -f "%:p:r"<CR>', desc = 'Clean Binary' },
      { '<leader>cf', '<cmd>lua vim.lsp.buf.format()<CR>', desc = 'Format' },

      -- Rust (usando RustLsp de rustaceanvim)
      { '<leader>cR', group = 'Rust' },
      { '<leader>cRa', '<cmd>RustLsp codeAction<CR>', desc = 'Code Action' },
      { '<leader>cRe', '<cmd>RustLsp expandMacro<CR>', desc = 'Expand Macro' },
      { '<leader>cRt', '<cmd>RustLsp testables<CR>', desc = 'Run Tests' },
      { '<leader>cRu', '<cmd>RustLsp runnables<CR>', desc = 'Runnables' },
      { '<leader>cRR', '<cmd>RustLsp codelens run<CR>', desc = 'Run CodeLens' },
      { '<leader>cRf', '<cmd>RustLsp flyCheck<CR>', desc = 'Fly Check (clippy)' },

      -- LSP Info
      { '<leader>cl', group = 'LSP' },
      { '<leader>cli', '<cmd>LspInfo<CR>', desc = 'Info' },
      { '<leader>clr', '<cmd>LspRestart<CR>', desc = 'Restart' },

      -- Git
      { '<leader>cs', group = 'Git' },
      { '<leader>csg', '<cmd>LazyGit<CR>', desc = 'LazyGit' },
    })
  end,
}

