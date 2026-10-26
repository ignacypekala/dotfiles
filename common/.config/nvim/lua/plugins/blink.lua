return {
    "blink.cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    before = function()
        vim.cmd.packadd("blink.lib")
        require("lz.n").trigger_load("luasnip")
    end,
    after = function()
        local blink = require('blink.cmp')

        blink.setup({
            keymap = {
                preset = 'super-tab',
                ['<C-space>'] = false,
                ['<C-K>'] = false,
                ['<C-S>'] = {
                    'show_signature',
                    'show_signature_documentation',
                    'hide_signature',
                },
                -- ['<C-e>'] = { 'hide', 'fallback' },
                --
                -- ['<Tab>'] = {
                --     function(cmp)
                --         if cmp.snippet_active() then return cmp.accept()
                --         else return cmp.select_and_accept() end
                --     end,
                --     'snippet_forward',
                --     'fallback'
                -- },
                -- ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
                --
                -- ['<Up>'] = { 'select_prev', 'fallback' },
                -- ['<Down>'] = { 'select_next', 'fallback' },
                -- ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
                -- ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
                --
                ['<C-b>'] = { 'show_documentation', 'scroll_documentation_up' },
                ['<C-f>'] = { 'show_documentation', 'scroll_documentation_down' },
            },
            appearance = {
                nerd_font_variant = 'mono'
            },
            completion = {
                list = {
                    selection = {
                        preselect = true,
                        auto_insert = false,
                    }
                },
                menu = {
                    border = 'none',
                    auto_show = true,
                    auto_show_delay_ms = 0,
                    draw = {
                        columns = {
                            { "kind_icon",         "label",       gap = 1 },
                            { "label_description", "source_name", gap = 0 }
                        },
                    },
                    direction_priority = { 's', 'n' }
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 2000,
                },
                ghost_text = {
                    enabled = true,
                    show_first_line_only = false
                }
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
                    direction_priority = { 'n', 's' },
                },
            },
        })
    end
}

