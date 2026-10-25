return {
    "oil.nvim",
    cmd = "Oil",
    keys = {
        { "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
    },
    ---@diagnostic disable-next-line: param-type-mismatch
    lazy = not (vim.fn.argc() > 0 and vim.fn.isdirectory(vim.fn.argv(0)) == 1),
    before = function()
        vim.cmd.packadd("mini.icons")
        require("mini.icons").setup({})
    end,
    after = function()
        require('oil').setup({})
        vim.keymap.set(
            "n", "-",
            "<CMD>Oil<CR>",
            { desc = "Open parent directory" }
        )
    end
}
