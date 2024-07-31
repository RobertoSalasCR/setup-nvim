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
    },
    config = function()
        local lspconfig = require('lspconfig')
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        local util = require('lspconfig.util')
        local lspsaga = require('lspsaga')
        local wk = require('which-key')
        local builtin = require('telescope.builtin')

        -- Lsp Servers Default Capabilities
        local servers = {
            'lua_ls',
            'gopls',
            'templ',
            'html',
            'cssls',
            'tsserver',
            'marksman',
            'markdown_oxide',
        }
        capabilities.workspace = {
            didChangeWatchedFiles = { dynamicRegistration = true }
        }
        for _, lsp in ipairs(servers) do
            lspconfig[lsp].setup { capabilities = capabilities, }
        end

        -- Higlight Colors
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

        -- Inlay Hints
        require('inlay-hints').setup({
            commands = { enable = true },
            autocmd = { enable = true },
        })

        -- LSP Format
        require('lsp-format').setup({})
        local lsp_format = require('lsp-format')

        lspconfig.gopls.setup({
            cmd = { 'gopls' },
            filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
            root_dir = util.root_pattern('go.work', 'go.mod', '.git'),
            single_file_support = true,
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

        lspconfig.templ.setup({
            cmd = { 'templ', 'lsp' },
            filetypes = { 'templ' },
            root_dir = util.root_pattern('go.work', 'go.mod', '.git'),
            on_attach = function(client, bufnr)
                lsp_format.on_attach(client, bufnr)
            end
        })

        lspconfig.lua_ls.setup({
            cmd = { 'lua-language-server' },
            filetypes = { 'lua' },
            root_dir = util.root_pattern('.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'selene.toml',
                'selene.yml', '.git'),
            single_file_support = true,
            settings = {
                lua = {
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
        lspconfig.tsserver.setup({
            cmd = { 'typescript-language-server', '--stdio' },
            filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
            init_options = { hostInfo = 'neovim' },
            root_dir = util.root_pattern('tsconfig.json', 'jsconfig.json', 'package.json', '.git'),
            single_file_support = true,
            on_attach = function(client, bufnr)
                lsp_format.on_attach(client, bufnr)
            end,
        })
        lspconfig.html.setup({ on_attach = lsp_format.on_attach })
        lspconfig.cssls.setup({ on_attach = lsp_format.on_attach })
        lspconfig.marksman.setup({ on_attach = lsp_format.on_attach })
        lspconfig.markdown_oxide.setup({ on_attach = lsp_format.on_attach })

        local cmp = require('cmp')
        require('luasnip.loaders.from_vscode').lazy_load()
        local luasnip = require('luasnip')

        -- Runner
        require('runner').setup({})

        -- CMP & LuaSnip
        require('luasnip').setup({})

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end
            },
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
                    elseif luasnip.locallly_jumpable(-1) then
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

        -- Lspsaga
        -- Lspsaga Wiki for complete documentation
        -- https://nvimdev.github.io/lspsaga/
        lspsaga.setup({
            lightbulb = {
                enable = false,
                sign = true,
                virtual_text = true,
                debounce = 10,
                sign_priority = 40,
            },
        })


        -- Which-Key Bindings
        wk.add({
            { '<leader>c',    group = 'Code' },
            { '<leader>ca',   '<cmd>Lspsaga code_action<cr>',     desc = 'Code Action' },
            { '<leader>cd',   '<cmd>Lspsaga goto_definition<cr>', desc = 'Goto Definition' },
            { '<leader>cg',   '<cmd>LazyGit<cr>',                 desc = 'LazyGit' },
            { '<leader>ch',   '<cmd>Lspsaga hover_doc<cr>',       desc = 'Hover' },
            { '<leader>ci',   '<cmd>InlayHintsToggle<cr>',        desc = "Inlay Hints Toggle" },
            { '<leader>cl',   group = 'Lsp' },
            { '<leader>cli',  '<cmd>LspInfo<cr>',                 desc = 'Info' },
            { '<leader>cll',  '<cmd>LspLog<cr>',                  desc = 'Log' },
            { '<leader>clr',  '<cmd>LspRestart<cr>',              desc = 'Restart' },
            { '<leader>cls',  '<cmd>LspStart<cr>',                desc = 'Start' },
            { '<leader>clS',  '<cmd>LspStop<cr>',                 desc = 'Stop' },
            { '<leader>co',   '<cmd>Lspsaga outline<cr>',         desc = 'Outline' },
            { '<leader>cp',   group = 'Pickers' },
            { '<leader>cpd',  builtin.lsp_definitions,            desc = 'Definitions' },
            { '<leader>cpg',  group = 'Git' },
            { '<leader>cpgb', builtin.git_branches,               desc = 'Branches' },
            { '<leader>cpgc', builtin.git_commits,                desc = 'Commmits' },
            { '<leader>cpgs', builtin.git_status,                 desc = 'Status' },
            { '<leader>cpi',  builtin.lsp_implementations,        desc = 'Implementations' },
            { '<leader>cpr',  builtin.lsp_references,             desc = 'References' },
            { '<leader>cpt',  builtin.treesitter,                 desc = 'Treesitter Mode' },
            { '<leader>cr',   group = 'Runner' },
            { '<leader>cra',  '<cmd>AutoRunner<cr>',              desc = 'AutoRun' },
            { '<leader>crs',  '<cmd>AutoRunnerStop<cr>',          desc = 'Stop' },
            { '<leader>ct',   '<cmd>Lspsaga term_toggle<cr>',     desc = 'Terminal' }
        })

        -- Autocmd
        vim.cmd([[ autocmd BufWritePost * InlayHintsToggle ]])
    end
}
