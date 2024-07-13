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
    },
    config = function()
        local lspconfig = require('lspconfig')
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        local lspsaga = require('lspsaga')
        local wk = require('which-key')
        local builtin = require('telescope.builtin')

        -- Lsp Servers Default Capabilities
        local servers = {
            'lua_ls',
            'gopls',
            'html',
            'cssls',
            'tsserver',
            'marksman',
            'markdown_oxide',
        }
        for _, lsp in ipairs(servers) do
            lspconfig[lsp].setup { capabilities = capabilities, }
        end

        -- LSP Format
        require('lsp-format').setup({})
        local lsp_format = require('lsp-format')

        lspconfig.lua_ls.setup({ on_attach = lsp_format.on_attach })
        lspconfig.gopls.setup({ on_attach = lsp_format.on_attach })
        lspconfig.html.setup({ on_attach = lsp_format.on_attach })
        lspconfig.cssls.setup({ on_attach = lsp_format.on_attach })
        lspconfig.tsserver.setup({ on_attach = lsp_format.on_attach })
        lspconfig.marksman.setup({ on_attach = lsp_format.on_attach })
        lspconfig.markdown_oxide.setup({ on_attach = lsp_format.on_attach })

        local cmp = require('cmp')
        require('luasnip.loaders.from_vscode').lazy_load()
        local luasnip = require('luasnip')

        -- Runner
        require('runner').setup({})

        -- CMP & LuaSnip
        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end
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
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
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
            { '<leader>cg',   '<cmd>Lspsaga goto_definition<cr>', desc = 'Goto Definition' },
            { '<leader>ch',   '<cmd>Lspsaga hover_doc<cr>',       desc = 'Hover' },
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
    end
}
