local github = require("utils.pack_providers").github

vim.pack.add({
    {
        src = github .. "saghen/blink.cmp",
        version = "v1"
    },
    github .. "saghen/blink.lib"
})

local blink = require('blink.cmp')

-- blink.build():wait(60000)
blink.setup({
    keymap = {
        preset = 'default',
        ['<C-k>'] = false,
    },
    appearance = {
        nerd_font_variant = 'mono'
    },
    completion = {
        menu = {
            border = 'none',
            auto_show = true,
            auto_show_delay_ms = 0,
            draw = {
                columns = {
                    { "kind_icon",         "label",       gap = 1 },
                    { "label_description", "source_name", gap = 1 }
                },
            },
        },
        documentation = { auto_show = false },
    },
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
    signature = {
        enabled = true,
        window = {
            border = 'space'
        }
    },
})
