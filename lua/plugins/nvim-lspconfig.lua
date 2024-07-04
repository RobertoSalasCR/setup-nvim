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
        local servers = { 'lua_ls', 'gopls' }
        local wk = require('which-key')

        -- Lsp Servers Default Capabilities
        for _, lsp in ipairs(servers) do
            lspconfig[lsp].setup { capabilities = capabilities, }
        end

        -- LSP Format
        require('lsp-format').setup({})
        local lsp_format = require('lsp-format')

        lspconfig.lua_ls.setup({ on_attach = lsp_format.on_attach })
        lspconfig.gopls.setup({ on_attach = lsp_format.on_attach })

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
            }),
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


        -- Which-Key bindings
        wk.register({
            c = {
                name = 'Code',
                a = { mode = { 'n' }, '<cmd>Lspsaga code_action<cr>', 'Code Action' },
                c = {
                    name = 'Call Hierarchy',
                    i = { mode = { 'n' }, '<cmd>Lspsaga incoming_calls<cr>', 'Incoming Calls' },
                    o = { mode = { 'n' }, '<cmd>Lspsaga outgoing_calls<cr>', 'Outgoing Calls' },
                },
                f = { mode = { 'n' }, '<cmd>Lspsaga finder<cr>', 'Finder' },
                g = { mode = { 'n' }, '<cmd>Lspsaga goto_definition<cr>', 'Goto Definition' },
                h = { mode = { 'n' }, '<cmd>Lspsaga hover_doc<cr>', 'Hover Doc' },
                i = { mode = { 'n' }, '<cmd>Lspsaga finder imp<cr>', 'Implement' },
                l = {
                    name = 'Lsp',
                    i = { mode = { 'n' }, '<cmd>LspInfo<cr>', 'LspInfo' },
                    l = { mode = { 'n' }, '<cmd>LspLog<cr>', 'LspLog' },
                    r = { mode = { 'n' }, '<cmd>LspRestart<cr>', 'LspRestart' },
                    s = { mode = { 'n' }, '<cmd>LspStop<cr>', 'LspStop' },
                    S = { mode = { 'n' }, '<cmd>LspStart<cr>', 'LspStart' },
                    ['?'] = { mode = { 'n' }, '<cmd>help lspconfig<cr>', 'Help' },
                },
                o = { mode = { 'n' }, '<cmd>Lspsaga outline<cr>', 'Outline' },
                r = {
                    name = 'Runner',
                    a = { mode = { 'n' }, '<cmd>AutoRunner<cr>', 'AutoRun On Save' },
                    r = { mode = { 'n' }, '<cmd>Runner<cr>', 'Run' },
                    s = { mode = { 'n' }, '<cmd>AutoRunnerStop<cr>', 'AutoRun Stop' },
                },
                t = { mode = { 'n', 't' }, '<cmd>Lspsaga term_toggle<cr>', 'Terminal' },
            },
        }, { prefix = '<leader>' })
    end
}
