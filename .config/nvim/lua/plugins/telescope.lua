local github = require("utils.pack_providers").github

require("config.plugin_build").set_build_command(
    "telescope-fzf-native.nvim",
    {
        "cmake", "-S.", "-Bbuild", "-DCMAKE_BUILD_TYPE=Release",
        " && ", "cmake", "--build build", "--config Release", "--target install"
    }
)

vim.pack.add({
    github .. "nvim-telescope/telescope.nvim",
    github .. "nvim-lua/plenary.nvim",
    github .. "nvim-tree/nvim-web-devicons",
    github .. "nvim-telescope/telescope-fzf-native.nvim",
    github .. "nvim-telescope/telescope-ui-select.nvim"
})

require("nvim-web-devicons").setup({})

local telescope = require('telescope')
local themes = require('telescope.themes')
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')

telescope.load_extension("ui-select")

local dropdown = {
    dynamic_preview_title = true,
    borderchars = { "▄", "█", "▀", "█", "▄", "▄", "▀", "▀" },
    preview = true,
    theme = "dropdown"
}
local dropdown_no_preview = {
    preview = false,
    borderchars = { "▄", "█", "▀", "█", "▄", "▄", "▀", "▀" },
    theme = "dropdown"
}

telescope.setup({
    extensions = {
        fzf = {},
        ["ui-select"] = {
            themes.get_dropdown({
                preview = false,
            })
        },
    },
    defaults = {
        border = true,
        color_devicons = false,
        borderchars = { "▄", "█", "▀", "█", "▄", "▄", "▀", "▀" },
        layout_config = {
            prompt_position = "top",
            width = 0.5,
            height = 20,
        },
        preview = false,
        mappings = {
            i = {
                ["<esc>"] = actions.close,
                ["<Tab>"] = actions.move_selection_next,
                ["<S-Tab>"] = actions.move_selection_previous,
                ["<C-p>"] = actions.cycle_history_prev,
                ["<C-n>"] = actions.cycle_history_next
            }
        },
    },
    pickers = {
        git_files = dropdown_no_preview,
        find_files = dropdown_no_preview,
        help_tags = dropdown,
        buffers = dropdown_no_preview,
        man_pages = dropdown,
        keymaps = dropdown,
        treesitter = dropdown,
        live_grep = dropdown,
    },

})


local has_git = function()
    vim.system({ 'git', 'status' }, {},
        function(obj)
            vim.g.cwd_has_git = obj.code == 0
        end
    )
end
vim.api.nvim_create_autocmd('DirChanged', {
    callback = has_git
})
has_git()

vim.keymap.set('n', '<leader>f',
    function()
        builtin.find_files({
            cwd = vim.fn.getcwd(),
            hidden = false,
        })
    end
)
vim.keymap.set('n', '<leader>F',
    function()
        builtin.find_files({
            cwd = vim.fn.getcwd(),
            hidden = true,
        })
    end
)

vim.keymap.set('n', '<leader>g',
    function()
        if vim.g.cwd_has_git then
            builtin.git_files({
                prompt_title = "Git files",
                git_command = {
                    "git",
                    "-c",
                    "core.quotepath=false",
                    "ls-files",
                    "--exclude-standard",
                    "--cached", -- all
                    "--others", -- untracked
                    "--modified",
                }
            })
        else
            builtin.find_files({
                prompt_title = "Find files (no git in this directory)",
                cwd = vim.fn.getcwd(),
                hidden = false,
            })
        end
    end
)

vim.keymap.set('n', '<leader>G',
    function()
        if vim.g.cwd_has_git then
            builtin.git_files({
                prompt_title = "Git files (all)",
                git_command = {
                    "git",
                    "-c",
                    "core.quotepath=false",
                    "ls-files",
                    "--exclude-standard",
                    "--cached", -- all
                    "--others", -- untracked
                    "--modified",
                    "--ignored",
                }
            })
        else
            builtin.find_files({
                prompt_title = "Find files (all) (no git in this directory)",
                cwd = vim.fn.getcwd(),
                hidden = true,
            })
        end
    end
)

vim.keymap.set('n', '<leader>v',
    function()
        if vim.g.cwd_has_git then
            builtin.git_files({
                prompt_title = "Git modified files",
                git_command = {
                    "git",
                    "-c",
                    "core.quotepath=false",
                    "ls-files",
                    "--exclude-standard",
                    "--modified",
                }
            })
        else
            vim.notify("This is not a git repository.", vim.log.levels.WARN)
        end
    end
)



vim.keymap.set('n', '<leader>nv',
    function()
        builtin.find_files({ cwd = vim.fn.stdpath('config') })
    end
)
vim.keymap.set('n', '<leader>ndv',
    function()
        builtin.find_files({ cwd = vim.fn.stdpath('data') })
    end
)

vim.keymap.set('n', '<leader>b', builtin.buffers)
vim.keymap.set('n', '<leader>ht', builtin.help_tags)
vim.keymap.set('n', '<leader>k', builtin.keymaps)
vim.keymap.set('n', '<leader>m', builtin.man_pages)
vim.keymap.set('n', '<leader>t', builtin.treesitter)
vim.keymap.set('n', '<leader>l', builtin.live_grep)
vim.keymap.set('n', '<leader>L', function()
    builtin.live_grep({ hidden = true, glob_pattern = "!.git/**" })
end)

vim.keymap.set('n', '<leader>r', builtin.resume)
