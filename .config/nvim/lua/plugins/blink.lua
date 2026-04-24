vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(event)
        local kind = event.data.kind
        local name = event.data.spec.name
        if (name == "blink.cmp") and (kind == "install" or kind == "update") then
            require('blink.cmp').build():wait(60000)
        end
    end
})

local github = require("utils.pack_providers").github

vim.pack.add({
    github .. "saghen/blink.cmp",
    github .. "saghen/blink.lib"
})
require('blink.cmp').setup({
    keymap = {
        preset = 'default',
        ['<C-k>'] = false
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
