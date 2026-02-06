return {
    {
        "rcarriga/nvim-notify",
        config = function()
            require("notify").setup({
                render = "wrapped-compact",
                background_colour = "#000000",
            })
            vim.notify = require("notify")
        end
    }
}
