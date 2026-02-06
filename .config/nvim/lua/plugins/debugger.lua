return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            'theHamsta/nvim-dap-virtual-text',
            {
                "igorlfs/nvim-dap-view",
                ---@module 'dap-view'
                ---@type dapview.Config
                opts = {
                    winbar = {
                        sections = {"watches", "scopes", "breakpoints", "threads", "repl"},
                        default_section = "watches",
                    },
                    windows = {
                        terminal = {
                            -- start_hidden = false,
                        }
                    }
                },
            },
        },
        lazy= true,
        event = 'VeryLazy',
        config = function()
            local dap = require('dap')
            local dap_view = require('dap-view')
            require('nvim-dap-virtual-text').setup()

            vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint)
            vim.keymap.set('n', '<leader>dn', dap.continue)
            vim.keymap.set('n', '<leader>du', dap_view.toggle)

            -- Loads debugger configs under lua/debuggers/LANG.lua
            local debug_dir = vim.fn.stdpath("config") .. "/lua/debuggers"
            local modules = vim.fn.globpath(debug_dir, "*.lua", false, true)

            for _, file in ipairs(modules) do
                local modname = file
                    :gsub("^" .. vim.pesc(vim.fn.stdpath("config") .. "/lua/"), "")
                    :gsub("%.lua$", "")
                    :gsub("/", ".")

                local ok, mod = pcall(require, modname)
                if ok and type(mod) == "table" and type(mod.setup) == "function" then
                    mod.setup()
                end
            end
        end
    }
}
