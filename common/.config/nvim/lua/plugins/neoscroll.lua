return {
    "neoscroll.nvim",
    event = "DeferredUIEnter",
    after = function()
        require('neoscroll').setup({
            duration_multiplier = 0.7,
            easing = 'quadratic'
        })
    end
}
