return {
  'rcarriga/nvim-dap-ui',
  dependencies = {
    'mfussenegger/nvim-dap',
    'nvim-neotest/nvim-nio',
    'theHamsta/nvim-dap-virtual-text',
    'leoluz/nvim-dap-go',  -- ← Nueva dependencia para Go
  },
  config = function()
    local wk = require('which-key')
    local dap = require('dap')
    local dapui = require('dapui')
    local vtext = require('nvim-dap-virtual-text')

    dapui.setup()
    vtext.setup()

    -- =============================================================================
    -- Adapter codelldb usando mason.nvim (para Rust/Zig/C/etc.)
    -- =============================================================================
    local mason_path = vim.fn.stdpath('data') .. '/mason/packages/codelldb/extension/'
    local codelldb_path = mason_path .. 'adapter/codelldb'
    local liblldb_path = mason_path .. 'lldb/lib/liblldb.dylib'
    -- Si estás en Linux: 'liblldb.so'
    -- Si estás en Windows: 'liblldb.dll'
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
    -- Configuraciones de Zig para nvim-dap
    -- =============================================================================
    dap.configurations.zig = {
      {
        name = "Launch Zig (prompt path - recomendado)",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input(
            "Path to executable: ",
            vim.fn.getcwd() .. "/../zig-out/bin/",
            "file"
          )
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
      },
      {
        name = "Launch Zig (auto - asume raíz del proyecto)",
        type = "codelldb",
        request = "launch",
        program = "${workspaceFolder}/../zig-out/bin/${workspaceFolderBasename}",
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
      },
    }

    -- =============================================================================
    -- Configuraciones de Go para nvim-dap (usando nvim-dap-go)
    -- =============================================================================
    require('dap-go').setup({
      -- Opciones opcionales (puedes dejar vacío para defaults)
      -- delve = {
      --   path = "dlv",  -- ruta a dlv si no está en PATH
      --   initialize_timeout_sec = 20,
      --   port = "${port}",
      --   args = {},
      --   build_flags = "",
      -- },
    })

    -- =============================================================================
    -- Configuraciones de Odin para nvim-dap
    -- =============================================================================
    dap.configurations.odin = {
      {
        name = "Launch Odin (prompt path - recomendado)",
        type = "codelldb",
        request = "launch",
        program = function()
          -- Odin por defecto genera el ejecutable en la raíz con el nombre del directorio
          -- o puedes especificar -out:mi_ejecutable
          return vim.fn.input(
            "Path to executable: ",
            vim.fn.getcwd() .. "/",  -- Sugiere la raíz del proyecto
            "file"
          )
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},  -- Puedes agregar argumentos si los necesitas
      },
      {
        name = "Launch Odin (auto - asume nombre del proyecto)",
        type = "codelldb",
        request = "launch",
        program = "${workspaceFolder}/${workspaceFolderBasename}",
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
      },
    }
    
    -- =============================================================================
    -- Configuraciones de Pascal (Free Pascal / Object Pascal) para nvim-dap
    -- =============================================================================
    dap.configurations.pascal = {
      {
        name = "Launch Pascal (prompt path - recomendado)",
        type = "codelldb",
        request = "launch",
        program = function()
          -- Free Pascal genera el ejecutable en la raíz con el nombre del archivo o carpeta
          -- Usa -o para especificar nombre custom
          return vim.fn.input(
            "Path to executable: ",
            vim.fn.getcwd() .. "/",  -- Sugiere la carpeta actual
            "file"
          )
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},  -- Agrega argumentos si los necesitas
      },
      {
        name = "Launch Pascal (auto - asume nombre del archivo actual)",
        type = "codelldb",
        request = "launch",
        program = "${workspaceFolder}/${fileBasenameNoExtension}",
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
      },
    }

    -- =============================================================================
    -- Configuraciones de Fortran para nvim-dap
    -- =============================================================================
    dap.configurations.fortran = {
      {
        name = "Launch Fortran (prompt path - recomendado)",
        type = "codelldb",
        request = "launch",
        program = function()
          -- gfortran genera el ejecutable por defecto como 'a.out' o con -o nombre
          return vim.fn.input(
            "Path to executable: ",
            vim.fn.getcwd() .. "/",  -- Sugiere la carpeta actual
            "file"
          )
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},  -- Agrega argumentos si los necesitas
      },
      {
        name = "Launch Fortran (auto - asume a.out)",
        type = "codelldb",
        request = "launch",
        program = "${workspaceFolder}/a.out",
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
      },
    }


    -- =============================================================================
    -- Configuraciones de Nim para nvim-dap (compila automáticamente con debug info)
    -- =============================================================================
    dap.configurations.nim = {
      {
        name = "Debug Nim (compila + launch automáticamente)",
        type = "codelldb",
        request = "launch",
        program = function()
          -- Ruta al ejecutable generado (sin extensión)
          return "${workspaceFolder}/${fileBasenameNoExtension}"
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
        -- Hook que se ejecuta justo antes de lanzar el debugger
        runInTerminal = false,
        preLaunchTask = nil,  -- Ignoramos esto porque no funciona nativamente
        init_commands = function() end,  -- Placeholder
        -- En su lugar, usamos un wrapper con __call (método avanzado pero fiable)
      },
    }

    -- Wrapper mágico para compilar antes de lanzar (aplica a la config principal)
    dap.configurations.nim = {
      setmetatable({
        name = "Debug Nim (compila + launch automáticamente)",
        type = "codelldb",
        request = "launch",
        program = "${workspaceFolder}/${fileBasenameNoExtension}",
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
      }, {
        __call = function(config)
          local file = vim.fn.expand("%:p")  -- Ruta completa al archivo .nim actual
          local cmd = string.format("nim c --debugger:native --hints:off --verbosity:0 '%s'", file)

          print("Compilando Nim con debug info...")
          local result = vim.fn.system(cmd)

          if vim.v.shell_error ~= 0 then
            print("Error al compilar Nim:")
            print(result)
            return nil  -- Cancela el launch si falla la compilación
          end

          print("Compilación OK → Lanzando debugger")
          return config
        end,
      }),
      -- Opción manual de respaldo (por si quieres debuggear sin recompilar)
      {
        name = "Launch Nim (prompt path - manual)",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
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
    --wk.add({
    -- { '<leader>cR', group = 'Rust' },
    -- { '<leader>cRr', '<cmd>RustLsp runnables<CR>', desc = 'Rust Runnables' },
    -- { '<leader>cRt', '<cmd>RustLsp testables<CR>', desc = 'Rust Testables' },
    -- { '<leader>cRa', '<cmd>RustLsp codeAction<CR>', desc = 'Rust Code Actions' },
    --})
  end,
}
