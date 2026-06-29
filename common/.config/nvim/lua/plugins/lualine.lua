local github = require("utils.pack_providers").github

vim.pack.add({ github.."nvim-lualine/lualine.nvim" })

require("lualine").setup({
    options = {
        theme = require('lualine-theme'),
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
    },
    sections = {
        lualine_a = { 'mode', { 'selectioncount', padding = 1 } },
        lualine_b = { {
            'filename',
            icons_enabled = false,
            path = 0,
        } },
        lualine_c = { { 'filetype', icons_enabled = false } },
        lualine_x = {
            { 'encoding', padding = 1 },
            {
                'fileformat',
                symbols = { unix = 'LF', dos = 'CRLF', mac = 'MAC' },
                padding = 1,
            },
            "progress"
        },
        lualine_y = {
            'searchcount',
        },
        lualine_z = {
        },
    },
    inactive_sections = {
        lualine_a = {
        },
        lualine_b = {
            {
                'filename',
                icons_enabled = false,
                path = 2,
            }
        },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    }
})

