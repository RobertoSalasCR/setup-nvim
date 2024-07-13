return {
    -- This plugin needs you have pandoc installed on your machine
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    ft = { 'org' },
    config = function()
        require('orgmode').setup({
            org_agenda_files = '~/Workspace/notes/orgfiles/*',
            org_default_notes_file = '~/Workspace/notes/orgfiles/refile.org',
        })
        local wk = require('which-key')
        wk.add({
            { '<leader>o', group = 'Orgmode' },
        })
    end
}
