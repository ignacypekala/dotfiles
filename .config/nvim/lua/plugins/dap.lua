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
            dap.adapters = {}
            dap.configurations = {}
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
