
return {
    {
        'nvim-telescope/telescope.nvim',
        tag = 'v0.2.0',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { "nvim-tree/nvim-web-devicons", opts = {} },
            { "nvim-telescope/telescope-fzf-native.nvim", build = 'make' },
            "nvim-telescope/telescope-ui-select.nvim",
        },
        event = "VeryLazy",
        config = function()
            local telescope = require('telescope')
            local themes = require('telescope.themes')
            local actions = require('telescope.actions')
            local builtin = require('telescope.builtin')
            telescope.load_extension("ui-select")

            local dropdown = {
                dynamic_preview_title = true,
                borderchars = { "▄", "█", "▀", "█", "▄", "▄", "▀", "▀" },
                theme = "dropdown"
            }
            local dropdown_no_preview = {
                preview = false,
                borderchars = { "▄", "█", "▀", "█", "▄", "▄", "▀", "▀" },
                theme = "dropdown"
            }

            telescope.setup({
                extensions = {
                    fzf = {},
                    ["ui-select"] = {
                        themes.get_dropdown({
                            preview = false,
                        })
                    },
                },
                defaults = {
                    border = true,
                    color_devicons = false,
                    borderchars = { "▄", "█", "▀", "█", "▄", "▄", "▀", "▀" },
                    layout_config = {
                        prompt_position = "top",
                        width = 0.5,
                        height = 20,
                    },
                    preview = false,
                    mappings = {
                        i = {
                            ["<esc>"] = actions.close,
                        }
                    },
                },
                pickers = {
                    git_files = dropdown_no_preview,
                    find_files = dropdown_no_preview,
                    help_tags = dropdown,
                    buffers = dropdown_no_preview,
                    man_pages = dropdown,
                    keymaps = dropdown,
                    treesitter = dropdown,
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

            vim.keymap.set('n', '<leader>f',
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
            vim.keymap.set('n', '<leader>t', builtin.treesitter)
        end
    }
}
