return {
    "folke/which-key.nvim",
    enabled = false,
    dependencies = {
        "nvim-mini/mini.icons",
        "nvim-tree/nvim-web-devicons"
    },
    event = "VeryLazy",
    opts = {
        preset = "helix",
        delay = 1000,
        icons = {
            mappings = false,
        }
    },
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        }
    }
}
