return {
  'rcarriga/nvim-dap-ui',
  dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
  config = function()
    local wk = require('which-key')
    local dap = require('dap')
    local dapui = require('dapui')

    dapui.setup()

    -- =============================================================================
    -- Adapter codelldb usando mason.nvim
    -- =============================================================================
    local mason_path = vim.fn.stdpath('data') .. '/mason/packages/codelldb/extension/'
    local codelldb_path = mason_path .. 'adapter/codelldb'
    local liblldb_path = mason_path .. 'lldb/lib/liblldb.dylib'
    -- Si estás en Linux:    'liblldb.so'
    -- Si estás en Windows:  'liblldb.dll'

    dap.adapters.codelldb = {
      type = 'server',
      port = '${port}',
      executable = {
        command = codelldb_path,
        args = { '--liblldb', liblldb_path, '--port', '${port}' },
      },
    }

    -- =============================================================================
    -- Configuraciones de Rust para nvim-dap
    -- =============================================================================
    dap.configurations.rust = {
      {
        name = 'Debug Rust executable',
        type = 'codelldb',
        request = 'launch',
        program = function()
          return vim.fn.input(
            'Path to executable: ',
            vim.fn.getcwd() .. '/target/debug/',
            'file'
          )
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      },
      {
        name = 'Debug cargo test (no run)',
        type = 'codelldb',
        request = 'launch',
        cargo = {
          args = { 'test', '--no-run' },
        },
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      },
    }

    -- =============================================================================
    -- Integración con dap-ui
    -- =============================================================================
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end

    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end

    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end

    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    -- =============================================================================
    -- Which-Key mappings de Debug
    -- =============================================================================
    wk.add({
      { '<leader>c', group = 'Code' },
      { '<leader>cD', group = 'Debug' },

      { '<leader>cDt', dap.toggle_breakpoint, desc = 'Toggle Breakpoint' },
      { '<leader>cDc', dap.continue, desc = 'Continue / Start Debug' },
      { '<leader>cDo', dap.step_over, desc = 'Step Over' },
      { '<leader>cDi', dap.step_into, desc = 'Step Into' },
      {
        '<leader>cDu',
        function()
          dapui.toggle()
        end,
        desc = 'Toggle UI',
      },
    })


    -- =============================================================================
    -- Which-Key mappings extra de RustLsp (sin cargo build)
    -- =============================================================================
    wk.add({
      { '<leader>cR', group = 'Rust' },
      { '<leader>cRr', '<cmd>RustLsp runnables<CR>', desc = 'Rust Runnables' },
      { '<leader>cRt', '<cmd>RustLsp testables<CR>', desc = 'Rust Testables' },
      { '<leader>cRa', '<cmd>RustLsp codeAction<CR>', desc = 'Rust Code Actions' },
    })


  end,
}

