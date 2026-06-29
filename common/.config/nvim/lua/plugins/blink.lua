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
        ['<C-y>'] = false,
        ['<Tab>'] = { 'select_next', 'fallback'},
        ['<S-Tab>'] = { 'select_prev', 'fallback'},
        ['<Enter>'] = { 'accept', 'fallback'},
        ['<C-n>'] = { 'snippet_forward', 'fallback' },
        ['<C-p>'] = { 'snippet_backward', 'fallback' },
        ['<C-k>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-c>'] = { 'cancel', 'fallback' }
    },
    appearance = {
        nerd_font_variant = 'mono'
    },
    completion = {
        list = {
            selection = {
                preselect = false,
                auto_insert = true,
            }
        },
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
        documentation = {
            auto_show = false,
            auto_show_delay_ms = 0,
        },
    },
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    snippets = {
        preset = 'luasnip'
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
    signature = {
        enabled = true,
        window = {
            border = 'space'
        }
    },
})
