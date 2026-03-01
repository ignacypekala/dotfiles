return {
    'saghen/blink.cmp',
    -- use a release tag to download pre-built binaries
    version = '1.*',
    lazy = true,
    event = 'VeryLazy',
    opts = {
        keymap = { preset = 'default' },
        appearance = {
            nerd_font_variant = 'Nerd Font Mono'
        },
        completion = {
            menu = {
                auto_show = true,
                auto_show_delay_ms = 0,
                draw = {
                    columns = {
                        {"kind_icon", "label", gap = 1},
                        {"label_description", "source_name", gap = 1}
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
    },
    opts_extend = { "sources.default" }
}
