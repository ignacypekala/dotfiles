local github = require("utils.pack_providers").github

vim.pack.add({
    github .. "mfussenegger/nvim-dap",
    github .. "mfussenegger/nvim-jdtls",
    github .. "theHamsta/nvim-dap-virtual-text",
    github .. "igorlfs/nvim-dap-view"
})

local dap = require('dap')
require("nvim-dap-virtual-text").setup()

-- Java adapter is managed by nvim-jdtls
dap.adapters = {
    lldb = {
        type = "executable",
        command = "lldb-dap",
    }
}

vim.keymap.set('n', '<leader>dB', dap.toggle_breakpoint)
vim.keymap.set('n', '<leader>dbi',
    function ()
        local condition = vim.fn.input(
            "Enter breakpoint condition: "
        )
        dap.set_breakpoint(condition)
    end
)
vim.keymap.set('n', '<leader>dbl', dap.list_breakpoints)
vim.keymap.set('n', '<leader>dbc', dap.clear_breakpoints)
vim.keymap.set('n', '<leader>dr', dap.restart)
vim.keymap.set('n', '<leader>dl', dap.run_last)
vim.keymap.set('n', '<leader>dt', dap.terminate)

vim.keymap.set('n', '<Up>',
    function() require('dap').continue() end
)
vim.keymap.set('n', '<Down>',
    function() require('dap').step_over() end
)
vim.keymap.set('n', '<Right>',
    function() require('dap').step_into() end
)
vim.keymap.set('n', '<Left>',
    function() require('dap').step_out() end
)

local dap_view = require('dap-view')
dap_view.setup({
    winbar = {
        show_keymap_hints = false,
        base_sections = {
            breakpoints = { label = "B", keymap = "B" },
            scopes = { label = "S", keymap = "S" },
            exceptions = { label = "E", keymap = "E" },
            watches = { label = "W", keymap = "W" },
            threads = { label = "T", keymap = "T" },
            repl = { label = "R", keymap = "R" },
            sessions = { label = "K", keymap = "K" },
            console = { label = "C", keymap = "C" },
        },
    },
    windows = {
        position = "right",
        size = 0.4,
    }
})
vim.keymap.set('n', '<leader>dv', dap_view.toggle)

vim.api.nvim_create_autocmd("BufNew", {
    pattern = { "*.c", "*.cpp", "*.asm" },
    once = true,
    callback = function ()
        require('debuggers.lldb')
    end
})

vim.api.nvim_create_autocmd("BufNew", {
    pattern = { "*.java "},
    once = true,
    callback = function ()
        require('debuggers.java')
    end
})

