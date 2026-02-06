return {
    {
        -- "vague-theme/vague.nvim",
        -- "rebelot/kanagawa.nvim",
        -- "nyoom-engineering/oxocarbon.nvim",
        "olivercederborg/poimandres.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other plugins
        config = function()
            require('poimandres').setup({
                bold_vert_split = true,
                dim_nc_background = true,
                disable_background = true,
            })
            vim.cmd("colorscheme poimandres")
            -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
            -- vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
        end
    },
}
