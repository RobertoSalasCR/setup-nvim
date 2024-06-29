------------------------------------------------------
--- You need to have installed Lazygit on your machine
------------------------------------------------------
return {
    'kdheepak/lazygit.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope.nvim',
    },
    config = function()
        local wk = require('which-key')

        -- Which-Key Bindings
        wk.register({
            g = {
                name = 'Git',
                c = { mode = { 'n' }, '<cmd>LazyGitConfig<cr>', 'Config File' },
                f = { mode = { 'n' }, '<cmd>LazyGitFilter<cr>', 'Filter' },
                l = { mode = { 'n' }, '<cmd>LazyGit<cr>', 'LazyGit' },
            },
        }, { prefix = '<leader>' })
    end
}
