local github = require("utils.pack_providers").github
vim.pack.add({ github .. "windwp/nvim-autopairs" })
local rule = require("nvim-autopairs.rule")
local cond = require("nvim-autopairs.conds")
local ts_conds = require("nvim-autopairs.ts-conds")
local autopairs = require("nvim-autopairs")
autopairs.setup()


autopairs.add_rules({
    rule("$", "$", { "typst" })
        :with_pair(ts_conds.is_not_ts_node({ "math" })),
    rule(" ", " ", "typst")
        :with_pair(function(opts)
            -- Only trigger if the cursor is exactly between two `$` signs
            local pair = opts.line:sub(opts.col - 1, opts.col)
            return pair == "$$"
        end)
        :with_move(cond.none())
        :with_cr(cond.none())
        :with_del(function(opts)
            -- When hitting Backspace, check if the cursor is inside `$  $`
            local col = vim.api.nvim_win_get_cursor(0)[2]
            local context = opts.line:sub(col - 1, col + 2)
            return context == "$  $"
        end),
    rule("|", "|", { "typst" })
        :with_pair(ts_conds.is_not_ts_node({ "math" })),
})
