return {
    'mikavilpas/yazi.nvim',
    event = "VeryLazy",
    opts = { open_for_directories = true },
    floating_window_scaling_factor = 0.9,

    config = function()
        local wk = require('which-key') 
        wk.add({
            { '<leader>ey', '<cmd>Yazi<cr>', desc = 'Yazi File Manager' }
        })
    end
}
