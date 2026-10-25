return {
    "blink.cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    before = function()
        vim.cmd.packadd("blink.lib")
        require("lz.n").trigger_load("luasnip")
    end,
    after = function()
        local blink = require('blink.cmp')

        print("blink")
        blink.setup({
            keymap = {
                preset = 'super-tab',
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
                    border = 'solid',
                }
            },
        })
    end
}

