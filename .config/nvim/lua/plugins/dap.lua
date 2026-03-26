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
            vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint)
            vim.keymap.set('n', '<leader>dn', dap.continue)

            require('debuggers.c').setup(dap);
        end
    },
    {
        "mfussenegger/nvim-jdtls",
        dependencies = {
            "mfussenegger/nvim-dap",
            "neovim/nvim-lspconfig",
        },
        lazy = true,
        event = "VeryLazy",
        config = function ()
            local bundles = {}
            local java_debug = vim.env.JAVA_DEBUG
            if java_debug ~= 0 then
                print(java_debug)
                bundles[1] = {
                    vim.fn.glob(java_debug, true)
                }
            end

            vim.lsp.config("jdtls", {
                settings = {
                    java = {
                        init_options = {
                            bundles = bundles
                        }
                    }
                }
            })
            vim.lsp.enable("jdtls")
        end
    }
}
