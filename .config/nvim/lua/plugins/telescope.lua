return {
    {
        'nvim-telescope/telescope.nvim',
        tag = 'v0.2.0',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { "nvim-tree/nvim-web-devicons", opts = {} },
            { "nvim-telescope/telescope-fzf-native.nvim", build = 'make' }
        },
        event = "VeryLazy",
        config = function()
            require('telescope').setup({
                color_devicons = false,
                extensions = {
                    fzf = {}
                },
                defaults = {
                    border = true,
                    mappings = {

                    },
                },
                pickers = {
                    git_files = {
                        theme = "dropdown"
                    },
                    find_files = {
                        theme = "dropdown"
                    },
                    help_tags = {
                        theme = "dropdown"
                    },
                    buffers = {
                        theme = "dropdown"
                    },
                    man_pages = {
                        theme = "dropdown"
                    }
                },

            })
            local has_git = function()
                vim.system({'git', 'status'}, {},
                    function(obj)
                        vim.g.cwd_has_git = obj.code == 0
                    end
                )
            end
            vim.api.nvim_create_autocmd('DirChanged', {
                callback = has_git
            })
            has_git()

            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff',
                function()
                    builtin.find_files({ cwd = vim.fn.getcwd(), hidden = true })
                end
            )
            vim.keymap.set('n', '<leader>g',
                function()
                    if vim.g.cwd_has_git then
                        builtin.git_files()
                    else
                        vim.notify("Not a git repository", vim.log.levels.WARN)
                    end
                end
            )
            vim.keymap.set('n', '<leader>nv',
                function()
                    builtin.find_files({ cwd = vim.fn.stdpath('config') })
                end
            )
            vim.keymap.set('n', '<leader>ndv',
                function()
                    builtin.find_files({ cwd = vim.fn.stdpath('data') })
                end
            )
            vim.keymap.set('n', '<leader>b', builtin.buffers)
            vim.keymap.set('n', '<leader>h', builtin.help_tags)
            vim.keymap.set('n', '<leader>k', builtin.keymaps)
            vim.keymap.set('n', '<leader>m', builtin.man_pages)
        end
    }
}
