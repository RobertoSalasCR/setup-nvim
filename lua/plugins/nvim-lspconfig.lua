-- Este archivo define la configuración del plugin nvim-lspconfig y sus dependencias.
-- Incluye la configuración específica para Zig (zls) y Odin (ols), además de handlers
-- en runner.nvim para asegurar la correcta ejecución.

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
        -- Importar las capacidades predeterminadas y las de cmp
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        local util = require('lspconfig.util')
        local lspsaga = require('lspsaga')
        local wk = require('which-key')
        local builtin = require('telescope.builtin')

        -- Servidores LSP a configurar con la configuración básica
        local servers = {
            'lua_ls',
            'gopls',
            'templ',
            'html',
            'cssls',
            'tsserver',
            'marksman',
            'markdown_oxide',
            'elixirls',
            'zls', -- Zig Language Server
            'ols', -- Odin Language Server
            -- 'rust_analyzer',
        }
        -- Configuración de capacidades de workspace para soportar watch files
        capabilities.workspace = {
            didChangeWatchedFiles = { dynamicRegistration = true }
        }
        -- Configuración genérica para los servidores de la lista
        for _, lsp in ipairs(servers) do
            -- Guardián de seguridad para el setup genérico
            if lspconfig[lsp] and lspconfig[lsp].setup then
                -- Se omiten los servidores con ajustes específicos (que se configuran más abajo).
                if lsp ~= 'elixirls' and lsp ~= 'rust_analyzer' and lsp ~= 'zls' and lsp ~= 'odinls' then
                    lspconfig[lsp].setup {
                        capabilities = capabilities,
                        on_attach = require('lsp-format').on_attach
                    }
                end
            end
        end

        -- Higlight Colors: Configuración para resaltar colores en archivos CSS/HTML, etc.
        require('nvim-highlight-colors').setup({
            -- Renders: Background, Foreground, Virtual
            render = 'virtual',
            enable_hex = true,
            enable_short_hex = true,
            enable_rgb = true,
            enable_hsl = true,
            enable_var_usage = true,
            enable_named_colors = true,
            enable_tailwind = true,
        })

        -- Inlay Hints: Configuración para mostrar sugerencias de tipos en línea
        require('inlay-hints').setup({
            commands = { enable = true },
            autocmd = { enable = true },
        })

        -- LSP Format: Configuración para formateo de código
        require('lsp-format').setup({})
        local lsp_format = require('lsp-format')

        -- Configuración específica de Go (gopls)
        if lspconfig.gopls and lspconfig.gopls.setup then
            lspconfig.gopls.setup({
                cmd = { 'gopls' },
                filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
                root_dir = util.root_pattern('go.work', 'go.mod', '.git'),
                single_file_support = true,
                capabilities = capabilities,
                settings = {
                    gopls = {
                        semanticTokens = true,
                        completeUnimported = true,
                        usePlaceholders = true,
                        staticcheck = true,
                        analyses = { unusedparams = true },
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
                on_attach = function(client, bufnr)
                    lsp_format.on_attach(client, bufnr)
                end,
            })
        end

        -- Configuración específica de Templ
        if lspconfig.templ and lspconfig.templ.setup then
            lspconfig.templ.setup({
                cmd = { 'templ', 'lsp' },
                filetypes = { 'templ' },
                root_dir = util.root_pattern('go.work', 'go.mod', '.git'),
                capabilities = capabilities,
                on_attach = function(client, bufnr)
                    lsp_format.on_attach(client, bufnr)
                end
            })
        end

        -- Configuración específica de Lua (lua_ls)
        if lspconfig.lua_ls and lspconfig.lua_ls.setup then
            lspconfig.lua_ls.setup({
                cmd = { 'lua-language-server' },
                filetypes = { 'lua' },
                root_dir = util.root_pattern('.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'selene.toml',
                    'selene.yml', '.git'),
                single_file_support = true,
                capabilities = capabilities,
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
                on_attach = function(client, bufnr)
                    lsp_format.on_attach(client, bufnr)
                end,
            })
        end

        -- Configuración específica de TypeScript/JavaScript (tsserver)
        if lspconfig.tsserver and lspconfig.tsserver.setup then
            lspconfig.tsserver.setup({
                cmd = { 'typescript-language-server', '--stdio' },
                filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
                init_options = { hostInfo = 'neovim' },
                root_dir = util.root_pattern('tsconfig.json', 'jsconfig.json', 'package.json', '.git'),
                single_file_support = true,
                capabilities = capabilities,
                on_attach = function(client, bufnr)
                    lsp_format.on_attach(client, bufnr)
                end,
            })
        end

        -- Configuración específica de Zig (zls)
        if lspconfig.zls and lspconfig.zls.setup then
            lspconfig.zls.setup({
                cmd = { 'zls' }, -- El ejecutable del servidor de lenguaje Zig
                filetypes = { 'zig' },
                root_dir = util.root_pattern('build.zig', '.git'),
                capabilities = capabilities,
                settings = {
                    zls = {
                        inlayHints = {
                            paramNames = true,
                            paramTypes = false,
                            autofix = true,
                        },
                    },
                },
                on_attach = function(client, bufnr)
                    lsp_format.on_attach(client, bufnr)
                end,
            })
        end

        -- Configuración específica de Odin (ols)
        if lspconfig.ols and lspconfig.ols.setup then
            lspconfig.ols.setup({
                -- Usamos 'ols' como el comando del ejecutable
                cmd = { 'ols' },
                filetypes = { 'odin' },
                root_dir = util.root_pattern('build.odin', '.git'),
                capabilities = capabilities,
                on_attach = function(client, bufnr)
                    lsp_format.on_attach(client, bufnr)
                end,
            })
        end

        -- Configuración específica de Elixir (elixirls)
        if lspconfig.elixirls and lspconfig.elixirls.setup then
            lspconfig.elixirls.setup({
                cmd = { 'elixir-ls' },
                filetypes = { 'elixir', 'eelixir', 'heex' },
                root_dir = util.root_pattern('mix.exs', '.git'),
                capabilities = capabilities,
                settings = {
                    elixirLS = {
                        dialyzerEnabled = false,
                        enableTestLenses = true,
                    },
                },
                on_attach = function(client, bufnr)
                    lsp_format.on_attach(client, bufnr)
                    vim.api.nvim_create_autocmd('BufEnter', {
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.codelens.refresh()
                        end,
                    })
                end,
            })
        end

        -- Configuración específica de Rust (rust-tools.nvim)
        require('rust-tools').setup({
            tools = {           -- Opciones específicas de rust-tools
                runnables = { use_telescope = true, },
                inlay_hints = { -- Opciones para Inlay Hints, compatibles con inlay-hints.nvim
                    only_current_line = true,
                },
                hover_actions = { border = 'single', },
            },
            server = { -- Opciones de configuración para rust-analyzer LSP
                cmd = { 'rust-analyzer' },
                filetypes = { 'rust' },
                root_dir = util.root_pattern('Cargo.toml', '.git'),
                capabilities = capabilities,
                settings = {
                    ['rust-analyzer'] = {
                        checkOnSave = {
                            command = 'clippy', -- Usar clippy para chequeos más estrictos al guardar
                            extraArgs = { '--no-deps' }
                        },
                        procMacro = {
                            enable = true, -- Necesario para macros procedimentales
                        },
                    },
                },
                on_attach = function(client, bufnr)
                    lsp_format.on_attach(client, bufnr)
                end,
            }
        })

        -- Runner: Configuración
        local filename = vim.fn.expand("%")
        local shell_handler = require('runner.handlers.helpers').shell_handler
        require('runner').setup({})
        require('runner').set_handler('odin', shell_handler('odin run .', true))
        require('runner').set_handler('zig', shell_handler('zig build run', true))
        require('runner').set_handler('elixir', shell_handler('elixir ' .. filename, true))


        local cmp = require('cmp')
        -- Carga de snippets
        require('luasnip.loaders.from_vscode').lazy_load()
        local luasnip = require('luasnip')

        -- CMP & LuaSnip: Configuración
        require('luasnip').setup({})

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end
            },
            -- Integración de nvim-highlight-colors para el formato
            formatting = {
                format = require('nvim-highlight-colors').format
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<CR>'] = cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                },
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

            cmp.setup.cmdline('/', {
                sources = {
                    { name = 'buffer' },
                },
            }),

            cmp.setup.cmdline(':', {
                sources = {
                    { name = 'path' },
                    { name = 'cmdline' },
                },
            })
        })

        -- Lspsaga: Configuración
        lspsaga.setup({
            lightbulb = {
                enable = false, -- Deshabilitado, podrías preferir un indicador distinto
                sign = true,
                virtual_text = true,
                debounce = 10,
                sign_priority = 40,
            },
        })


        -- Which-Key Bindings: Se añaden comandos
        wk.add({
            { '<leader>c',    group = 'Code' },
            { '<leader>ca',   '<cmd>Lspsaga code_action<cr>',        desc = 'Code Action' },
            { '<leader>cd',   '<cmd>Lspsaga goto_definition<cr>',    desc = 'Goto Definition' },
            { '<leader>cg',   '<cmd>LazyGit<cr>',                    desc = 'LazyGit' },
            { '<leader>ch',   '<cmd>Lspsaga hover_doc<cr>',          desc = 'Hover' },
            { '<leader>ci',   '<cmd>InlayHintsToggle<cr>',           desc = "Inlay Hints Toggle" },

            -- Comandos específicos para Rust-Analyzer
            { '<leader>cR',   group = 'Rust-Analyzer' },
            { '<leader>cRa',  '<cmd>RustCodeAction<cr>',             desc = 'Rust Code Action' },
            { '<leader>cRe',  '<cmd>RustExpandMacro<cr>',            desc = 'Expand Macro' },
            { '<leader>cRl',  '<cmd>RustToggleLsp<cr>',              desc = 'RA Toggle LSP' },
            { '<leader>cRr',  function() vim.lsp.codelens.run() end, desc = 'Run CodeLens (Test/Main)' },
            { '<leader>cRd',  '<cmd>RustOpenExternalDocs<cr>',       desc = 'Open External Docs' },
            { '<leader>cRf',  '<cmd>RustFmt<cr>',                    desc = 'Format (rust-analyzer)' },
            { '<leader>cRg',  '<cmd>RustViewCrateGraph<cr>',         desc = 'View Crate Graph' },
            { '<leader>cRh',  '<cmd>RustHl<cr>',                     desc = 'Toggle Highlighting' },
            { '<leader>cRi',  '<cmd>RustInfo<cr>',                   desc = 'Show RA Info' },
            { '<leader>cRs',  '<cmd>RustSSR<cr>',                    desc = 'SSR (Search & Replace)' },
            { '<leader>cRt',  '<cmd>RustTest<cr>',                   desc = 'Run Current Test' },
            { '<leader>cRu',  '<cmd>RustRunnables<cr>',              desc = 'Runnables (Telescope)' },

            -- Comandos específicos para Zig
            { '<leader>cZ',   group = 'Zig' },
            { '<leader>cZf',  '<cmd>lua vim.lsp.buf.format()<cr>',   desc = 'Format (Zig)' },         -- Zig usa el formateador estándar LSP
            { '<leader>cZr',  '<cmd>Runner -e zig run %<cr>',        desc = 'Run Current Zig File' }, -- Ejecutar el archivo actual con Runner
            { '<leader>cZa',  '<cmd>AutoRunner<cr>',                 desc = 'AutoRun (Zig)' },        -- Nuevo binding para AutoRun

            -- Comandos específicos para Elixir
            { '<leader>cE',   group = 'Elixir' },
            { '<leader>cEf',  '<cmd>lua vim.lsp.buf.format()<cr>',   desc = 'Format (Zig)' },     -- Zig usa el formateador estándar LSP
            { '<leader>cEr',  '<cmd>Runner elixir %<cr>',            desc = 'Run .exs File' },    -- Ejecutar el archivo actual con Runner
            { '<leader>cEa',  '<cmd>AutoRunner<cr>',                 desc = 'AutoRun (Elixir)' }, -- Nuevo binding para AutoRun

            -- Comandos específicos para Odin
            { '<leader>cO',   group = 'Odin' },
            { '<leader>cOf',  '<cmd>lua vim.lsp.buf.format()<cr>',   desc = 'Format (Odin)' },         -- Odin usa el formateador estándar LSP
            { '<leader>cOr',  '<cmd>Runner -e odin run %<cr>',       desc = 'Run Current Odin File' }, -- Ejecutar el archivo actual con Runner
            { '<leader>cOa',  '<cmd>AutoRunner<cr>',                 desc = 'AutoRun (Odin)' },        -- Nuevo binding para AutoRun

            { '<leader>cl',   group = 'Lsp' },
            { '<leader>cli',  '<cmd>LspInfo<cr>',                    desc = 'Info' },
            { '<leader>cll',  '<cmd>LspLog<cr>',                     desc = 'Log' },
            { '<leader>clr',  '<cmd>LspRestart<cr>',                 desc = 'Restart' },
            { '<leader>cls',  '<cmd>LspStart<cr>',                   desc = 'Start' },
            { '<leader>clS',  '<cmd>LspStop<cr>',                    desc = 'Stop' },
            { '<leader>co',   '<cmd>Lspsaga outline<cr>',            desc = 'Outline' },
            { '<leader>cp',   group = 'Pickers' },
            { '<leader>cpd',  builtin.lsp_definitions,               desc = 'Definitions' },
            { '<leader>cpg',  group = 'Git' },
            { '<leader>cpgb', builtin.git_branches,                  desc = 'Branches' },
            { '<leader>cpgc', builtin.git_commits,                   desc = 'Commmits' },
            { '<leader>cpgs', builtin.git_status,                    desc = 'Status' },
            { '<leader>cpi',  builtin.lsp_implementations,           desc = 'Implementations' },
            { '<leader>cpr',  builtin.lsp_references,                desc = 'References' },
            { '<leader>cpt',  builtin.treesitter,                    desc = 'Treesitter Mode' },
            { '<leader>cr',   group = 'Runner' },
            { '<leader>cra',  '<cmd>AutoRunner<cr>',                 desc = 'AutoRun (Generic)' },
            { '<leader>crs',  '<cmd>AutoRunnerStop<cr>',             desc = 'Stop' },
            { '<leader>ct',   '<cmd>Lspsaga term_toggle<cr>',        desc = 'Terminal' }
        })

        -- Autocmd: Se mantiene igual
        vim.cmd([[ autocmd BufWritePost * InlayHintsToggle ]])
    end
}
