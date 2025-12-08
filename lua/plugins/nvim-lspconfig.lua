-- Este archivo define y activa la configuración LSP utilizando el API canónico
-- de Neovim 0.11+ (vim.lsp.config y vim.lsp.enable).

return {
  'neovim/nvim-lspconfig',
  dependencies = {
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
    'simrat39/rust-tools.nvim',
  },
  config = function()
    local lspconfig = require('lspconfig')
    local util = lspconfig.util -- Acceso a utilidades como root_pattern
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    
    local lspsaga = require('lspsaga')
    local wk = require('which-key')
    local builtin = require('telescope.builtin')
    local lsp_format = require('lsp-format')

    -- [[ 1. Definición de la función on_attach ]]
    local on_attach = function(client, bufnr)
      lsp_format.on_attach(client, bufnr)

      -- Autoformato si el servidor lo soporta
      if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_buf_set_option(bufnr, 'formatexpr', 'v:lua.vim.lsp.buf.format({async = true})')
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
      map('n', '[d', vim.lsp.buf.diagnostic_prev, opts)
      map('n', ']d', vim.lsp.buf.diagnostic_next, opts)
    end
    -- [ FIN DE 1. Definición de la función on_attach ]


    -- [[ 2. Definición de la Configuración Canónica de Servidores ]]
    local SERVER_CONFIGS = {
      -- Go (gopls)
      gopls = {
        cmd = { 'gopls' },
        filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
        root_dir = util.root_pattern('go.work', 'go.mod', '.git'),
        settings = { gopls = { semanticTokens = true, completeUnimported = true, usePlaceholders = true, staticcheck = true, analyses = { unusedparams = true }, hints = { assignVariableTypes = true, compositeLiteralFields = true, compositeLiteralTypes = true, constantValues = true, functionTypeParameters = true, rangeVariableTypes = true } } },
      },

      -- Templ
      templ = {
        cmd = { 'templ', 'lsp' },
        filetypes = { 'templ' },
        root_dir = util.root_pattern('go.work', 'go.mod', '.git'),
      },

      -- Lua (lua_ls)
      lua_ls = {
        cmd = { 'lua-language-server' },
        filetypes = { 'lua' },
        root_dir = util.root_pattern('.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'selene.toml', 'selene.yml', '.git'),
        settings = { Lua = { diagnostics = { globals = { 'vim', 'it', 'describe', 'before_each', 'after_each' } }, workspace = { library = { [vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true }, maxPreload = 100000, checkThirdParty = false }, completion = { callSnippet = 'Replace', keywordSnippet = 'Replace' } } },
      },

      -- TypeScript/JavaScript (tsserver)
      tsserver = {
        cmd = { 'typescript-language-server', '--stdio' },
        filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
        init_options = { hostInfo = 'neovim' },
        root_dir = util.root_pattern('tsconfig.json', 'jsconfig.json', 'package.json', '.git'),
      },

      -- Zig (zls)
      zls = {
        cmd = { 'zls' },
        filetypes = { 'zig' },
        root_dir = util.root_pattern('build.zig', '.git'),
        settings = { zls = { inlayHints = { paramNames = true, paramTypes = false, autofix = true } } },
      },

      -- Odin (odinls) -- ESTE ES EL SERVIDOR QUE FALLA
      odinls = {
        cmd = { 'ols' },
        filetypes = { 'odin' },
        root_dir = util.root_pattern('build.odin', '.git'),
      },

      -- Elixir (elixirls)
      elixirls = {
        cmd = { 'elixir-ls' },
        filetypes = { 'elixir', 'eelixir', 'heex' },
        root_dir = util.root_pattern('mix.exs', '.git'),
        settings = { elixirLS = { dialyzerEnabled = false, enableTestLenses = true } },
        -- Nota: on_attach especial para Elixir
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
          vim.api.nvim_create_autocmd('BufEnter', { buffer = bufnr, callback = function() vim.lsp.codelens.refresh() end, })
        end,
      },
      
      -- Servidores simples
      html = { filetypes = { 'html', 'twig' } },
      cssls = { filetypes = { 'css', 'scss', 'less', 'sass' } },
      marksman = { filetypes = { 'markdown' } },
      markdown_oxide = { filetypes = { 'markdown' } },
    }
    
    -- Configuración Rust-Analyzer (gestionado por rust-tools.nvim)
    require('rust-tools').setup({
      tools = { runnables = { use_telescope = true, }, inlay_hints = { only_current_line = true, }, hover_actions = { border = 'single', }, },
      server = {
        cmd = { 'rust-analyzer' },
        filetypes = { 'rust' },
        root_dir = util.root_pattern('Cargo.toml', '.git'),
        capabilities = capabilities,
        settings = { ['rust-analyzer'] = { checkOnSave = { command = 'clippy', extraArgs = { '--no-deps' } }, procMacro = { enable = true, } } },
        on_attach = on_attach,
      }
    })


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
        -- Esto es lo que fuerza a que el servidor se active para sus filetypes
        vim.lsp.enable(name)
    end
    -- [ FIN DE 3. Aplicar Configuración ]


    -- Plugins de Soporte (Mantenidos igual)
    require('nvim-highlight-colors').setup({ render = 'virtual', enable_hex = true, enable_short_hex = true, enable_rgb = true, enable_hsl = true, enable_var_usage = true, enable_named_colors = true, enable_tailwind = true, })
    require('inlay-hints').setup({ commands = { enable = true }, autocmd = { enable = true }, })
    require('lsp-format').setup({})

    -- Runner: Configuración
    require('runner').setup({ auto_run = { enabled = true, commands = { zig = 'zig run %', odin = 'odin run %', } }, handlers = { zig = function(bufnr) vim.cmd("!zig run %") end, odin = function(bufnr) vim.cmd("!odin run %") end } })

    -- CMP & LuaSnip, Lspsaga, Which-Key (Mantenidos igual)
    local cmp = require('cmp')
    require('luasnip.loaders.from_vscode').lazy_load()
    local luasnip = require('luasnip')
    require('luasnip').setup({})

    cmp.setup({
      snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
      formatting = { format = require('nvim-highlight-colors').format },
      window = { completion = cmp.config.window.bordered(), documentation = cmp.config.window.bordered(), },
      mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true },
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then cmp.select_next_item()
          elseif luasnip.locally_jumpable() then luasnip.jump(1)
          else fallback() end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then luasnip.jump(-1)
          else fallback() end
        end, { 'i', 's' }),
      }),
      sources = cmp.config.sources({ { name = 'nvim_lsp' }, { name = 'luasnip' }, { name = 'buffer' }, { name = 'path' }, { name = 'cmdline' }, { name = 'orgmode' }, }),
      cmp.setup.cmdline('/', { sources = { { name = 'buffer' }, }, }),
      cmp.setup.cmdline(':', { sources = { { name = 'path' }, { name = 'cmdline' }, }, })
    })

    lspsaga.setup({ lightbulb = { enable = false, sign = true, virtual_text = true, debounce = 10, sign_priority = 40 } })

    -- Which-Key Mappings (Mantenidos igual)
    wk.add({
      { '<leader>c', group = 'Code' },
      { '<leader>ca', '<cmd>Lspsaga code_action<cr>', desc = 'Code Action' },
      { '<leader>cd', '<cmd>Lspsaga goto_definition<cr>', desc = 'Goto Definition' },
      { '<leader>cg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
      { '<leader>ch', '<cmd>Lspsaga hover_doc<cr>', desc = 'Hover' },
      { '<leader>ci', '<cmd>InlayHintsToggle<cr>', desc = "Inlay Hints Toggle" },
      { '<leader>cR', group = 'Rust-Analyzer' },
      { '<leader>cRa', '<cmd>RustCodeAction<cr>', desc = 'Rust Code Action' },
      { '<leader>cRe', '<cmd>RustExpandMacro<cr>', desc = 'Expand Macro' },
      { '<leader>cRl', '<cmd>RustToggleLsp<cr>', desc = 'RA Toggle LSP' },
      { '<leader>cRr', function() vim.lsp.codelens.run() end, desc = 'Run CodeLens (Test/Main)' },
      { '<leader>cRd', '<cmd>RustOpenExternalDocs<cr>', desc = 'Open External Docs' },
      { '<leader>cRf', '<cmd>RustFmt<cr>', desc = 'Format (rust-analyzer)' },
      { '<leader>cRg', '<cmd>RustViewCrateGraph<cr>', desc = 'View Crate Graph' },
      { '<leader>cRh', '<cmd>RustHl<cr>', desc = 'Toggle Highlighting' },
      { '<leader>cRi', '<cmd>RustInfo<cr>', desc = 'Show RA Info' },
      { '<leader>cRs', '<cmd>RustSSR<cr>', desc = 'SSR (Search & Replace)' },
      { '<leader>cRt', '<cmd>RustTest<cr>', desc = 'Run Current Test' },
      { '<leader>cRu', '<cmd>RustRunnables<cr>', desc = 'Runnables (Telescope)' },
      { '<leader>cZ', group = 'Zig' },
      { '<leader>cZf', '<cmd>lua vim.lsp.buf.format()<cr>', desc = 'Format (Zig)' },
      { '<leader>cZr', '<cmd>Runner -e zig run %<cr>', desc = 'Run Current Zig File' },
      { '<leader>cZa', '<cmd>AutoRunner<cr>', desc = 'AutoRun (Zig)' },
      { '<leader>cO', group = 'Odin' },
      { '<leader>cOf', '<cmd>lua vim.lsp.buf.format()<cr>', desc = 'Format (Odin)' },
      { '<leader>cOr', '<cmd>Runner -e odin run %<cr>', desc = 'Run Current Odin File' },
      { '<leader>cOa', '<cmd>AutoRunner<cr>', desc = 'AutoRun (Odin)' },
      { '<leader>cl', group = 'Lsp' },
      { '<leader>cli', '<cmd>LspInfo<cr>', desc = 'Info' },
      { '<leader>cll', '<cmd>LspLog<cr>', desc = 'Log' },
      { '<leader>clr', '<cmd>LspRestart<cr>', desc = 'Restart' },
      { '<leader>cls', '<cmd>LspStart<cr>', desc = 'Start' },
      { '<leader>clS', '<cmd>LspStop<cr>', desc = 'Stop' },
      { '<leader>co', '<cmd>Lspsaga outline<cr>', desc = 'Outline' },
      { '<leader>cp', group = 'Pickers' },
      { '<leader>cpd', builtin.lsp_definitions, desc = 'Definitions' },
      { '<leader>cpg', group = 'Git' },
      { '<leader>cpgb', builtin.git_branches, desc = 'Branches' },
      { '<leader>cpgc', builtin.git_commits, desc = 'Commmits' },
      { '<leader>cpgs', builtin.git_status, desc = 'Status' },
      { '<leader>cpi', builtin.lsp_implementations, desc = 'Implementations' },
      { '<leader>cpr', builtin.lsp_references, desc = 'References' },
      { '<leader>cpt', builtin.treesitter, desc = 'Treesitter Mode' },
      { '<leader>cr', group = 'Runner' },
      { '<leader>cra', '<cmd>AutoRunner<cr>', desc = 'AutoRun (Generic)' },
      { '<leader>crs', '<cmd>AutoRunnerStop<cr>', desc = 'Stop' },
      { '<leader>ct', '<cmd>Lspsaga term_toggle<cr>', desc = 'Terminal' }
    })
    
    vim.cmd([[ autocmd BufWritePost * InlayHintsToggle ]])
  end
}
