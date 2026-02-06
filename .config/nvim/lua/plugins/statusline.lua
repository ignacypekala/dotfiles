return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require("lualine").setup({
                options = {
                    component_separators = { left = " ", right = " " },
                    section_separators = { left = " ", right = " " },
                },
                sections = {
                    lualine_a = {
                        'mode',
                    },
                    lualine_b = {

                    },
                    lualine_c = {
                        'filename'
                    },

                    lualine_x = {
                        'encoding',
                        {
                            'fileformat',
                            symbols = {
                                unix = 'LF',
                                dos = 'CRLF',
                                mac = 'MAC'
                            }
                        },
                        'diff'
                    },
                    lualine_y = {
                        'selectioncount',
                    },
                    lualine_z = {
                        'branch'
                    },
                }
            })
        end
    }

}
