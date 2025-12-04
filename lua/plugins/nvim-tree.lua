-- Configuración del plugin NvimTree (Explorador de Archivos)
return {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
        'nvim-tree/nvim-web-devicons', -- Requerido para iconos
    },
    config = function()
        -- Importar el API de NvimTree para usar sus funciones de forma directa
        local api = require('nvim-tree.api')
        local wk = require('which-key')

        -- Usamos el util de lspconfig para detección de raíz (requiere el plugin lspconfig)
        -- Asegúrate de que el plugin 'nvim-lspconfig' esté cargado antes de 'nvim-tree.lua'
        local util = require('lspconfig.util')

        -- Función de detección de raíz: Si encuentra un mix.exs (Elixir) o .git, lo usa como raíz.
        local root_dir = util.root_pattern("mix.exs", ".git")

        -- *** FIX para 'on_init' y 'auto_close' que son opciones obsoletas ***

        -- Función para establecer el directorio de trabajo actual (CWD) al inicio del proyecto.
        -- Esta función replica la lógica que estaba en 'on_init'.
        local function set_project_root_cwd()
            -- CORREGIDO: Usamos vim.bo.filetype == 'NvimTree' en lugar de la API,
            -- ya que es más estable durante eventos como BufEnter.
            if vim.bo.buftype == 'terminal' or vim.bo.filetype == 'NvimTree' then
                return
            end

            -- Obtiene la ruta absoluta del archivo actual.
            local current_path = vim.fn.expand('%:p')

            -- Si el buffer no tiene nombre (scratch buffer), utiliza el CWD actual
            if current_path == '' then
                current_path = vim.loop.cwd()
            end

            -- 1. Intenta determinar la raíz del proyecto.
            local current_root = root_dir(current_path)

            if current_root and current_root ~= vim.loop.cwd() then
                -- 2. Cambiar el directorio de trabajo actual de Neovim al directorio raíz
                -- Usar pcall por si el directorio no existe (raro, pero previene errores)
                local success, result = pcall(vim.cmd, "cd " .. current_root)
                if not success then
                    -- Muestra un error si el comando 'cd' falla (opcional)
                    vim.notify("NvimTreeRootFix: Error al cambiar a la raíz: " .. result, vim.log.levels.ERROR)
                    return
                end

                -- 3. Opcional: Si NvimTree está abierto, refrescarlo para que muestre la nueva raíz
                if api.tree.is_visible() then
                    api.tree.change_root(current_root)
                    -- Nota: api.tree.refresh() ya está incluido en api.tree.change_root() si el CWD cambia.
                end
            end
        end

        -- Ejecutar la función para establecer la raíz del proyecto al iniciar Neovim
        -- o al entrar en un buffer.
        vim.api.nvim_create_autocmd({ "VimEnter", "BufEnter" }, {
            group = vim.api.nvim_create_augroup("NvimTreeRootFix", { clear = true }),
            callback = set_project_root_cwd,
        })

        -- Seguridad: Evita que Neovim cambie el CWD automáticamente por sí mismo (si 'autochdir' está habilitado).
        vim.opt.autochdir = false


        require('nvim-tree').setup({
            -- REMOVIDO 'auto_close' - no es una opción válida
            hijack_cursor = true,
            diagnostics = { enable = true },
            modified = { enable = true },
            reload_on_bufenter = true,
            select_prompts = true,

            -- REMOVIDO 'on_init' - la lógica se ha movido a la función 'set_project_root_cwd' y su Autocmd.

            -- 2. Asegura que NvimTree siga el CWD de Neovim.
            update_focused_file = {
                enable = true,
                update_cwd = true, -- **USADO:** Actualiza el CWD de Neovim al abrir un archivo
                update_root = false, -- La lógica del autocmd maneja el cambio inicial de raíz
                ignore_list = {},
            },

            view = {
                width = 30,    -- Se establece un ancho fijo de 30 para consistencia
                relativenumber = true, -- Se mantiene la numeración relativa en el explorador
                preserve_window_proportions = false,
            },

            renderer = {
                icons = {
                    git_placement = "before",
                    show = {
                        file = true,
                        folder = true,
                        folder_arrow = true,
                        git = true,
                    },
                },
            },

            actions = {
                open_file = { quit_on_open = false },
            },

            -- Deshabilitar la sobreescritura de netrw si usas otro explorador
            hijack_netrw = false,
        })

        -- Which-Key Bindings (tomadas de tu entrada)
        wk.add({
            { '<leader>e',   group = 'Explorer' },
            { '<leader>ec',  '<cmd>NvimTreeCollapse<cr>',                   desc = 'Collapse' },
            { '<leader>ee',  '<cmd>NvimTreeToggle<cr>',                     desc = 'Toggle' },
            { '<leader>ef',  '<cmd>NvimTreeFocus<cr>',                      desc = 'Focus' },
            { '<leader>er',  '<cmd>NvimTreeRefresh<cr>',                    desc = 'Refresh' },
            { '<leader>es',  '<cmd>NvimTreeFindFileToggle<cr>',             desc = 'Search File' },
            { '<leader>ea',  group = 'Actions' },
            -- [API ACTIONS: FILE SYSTEM MANIPULATION]
            { '<leader>ear', function() api.fs.rename() end,                desc = 'Rename (r)' },
            { '<leader>ean', function() api.fs.create() end,                desc = 'New File/Dir (a)' },
            { '<leader>ead', function() api.fs.remove() end,                desc = 'Delete (d)' },
            { '<leader>eam', function() api.fs.move() end,                  desc = 'Move (m)' },
            { '<leader>eat', function() api.fs.cut() end,                   desc = 'Cut (t)' }, -- Inicia la acción de cortar
            { '<leader>eac', function() api.fs.copy.node() end,             desc = 'Copy Node (c)' },
            { '<leader>eap', function() api.fs.paste() end,                 desc = 'Paste (p)' },
            -- [API ACTIONS: UTILITIES]
            { '<leader>eay', function() api.fs.copy.filename() end,         desc = 'Copy Filename (y)' },
            { '<leader>eaw', function() api.tree.change_root_to_node() end, desc = 'Change Root (w)' },
            { '<leader>eah', function() api.tree.change_root('~') end,      desc = 'Go to Home (~)' },
        })
    end
}
