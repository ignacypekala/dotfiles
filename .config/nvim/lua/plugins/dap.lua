return {
    {
        "mfussenegger/nvim-dap",
        enabled = true,
        dependencies = {
        },
        lazy= true,
        event = 'VeryLazy',
        config = function()
            local dap = require('dap')

            -- Dap adapters
            -- Java adapter is attached by nvim-jdtls in ftplugin/java.lua
            dap.adapters = {
                lldb = {
                    type = "executable",
                    command = "lldb-dap",
                }
            }

            vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint)
            vim.keymap.set('n', '<leader>dn', dap.continue)
        end
    },
    {
        "mfussenegger/nvim-jdtls",
        dependencies = {
            "mfussenegger/nvim-dap",
        },
        lazy = true,
        event = "VeryLazy",
    }
}
