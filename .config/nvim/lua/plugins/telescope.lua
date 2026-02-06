return {
    {
        'nvim-telescope/telescope.nvim',
        tag = 'v0.2.0',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { "nvim-tree/nvim-web-devicons", opts = {} },
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install'
            }

        },
        event = "VeryLazy",
        config = function()
            require('telescope').setup({
                extensions = {
                    fzf = {}
                },
                mappings = {

                },
                pickers = {
                    find_files = {
                        theme = 'dropdown'
                    },
                    help_tags = {
                        theme = 'dropdown',
                    },
                    buffers = {
                        theme = 'dropdown',
                    }
                },

            })

            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = 'Telescope files' })
            vim.keymap.set('n', '<leader>nv',
                function()
                    builtin.find_files({ cwd = vim.fn.stdpath('config') })
                end,
                { desc = 'Telescope files in nvim config' }
            )
            vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = 'Telescope buffers' })
            vim.keymap.set('n', '<leader>h', builtin.help_tags, { desc = 'Telescope help tags' })
            vim.keymap.set('n', '<leader>k', builtin.keymaps, { desc = 'Telescope keymappings' })
        end
    }
}
