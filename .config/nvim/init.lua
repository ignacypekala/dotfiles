vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.numberwidth = 4

vim.opt.wrap = false

vim.opt.cursorline = true
vim.opt.cursorlineopt = 'number'
vim.opt.scrolloff = 5

-- Normal cursor but with a beam when typing
vim.opt.guicursor = "n-v-sm:block,i-c-ci-ve:ver25-blinkon500,"..
    "r-cr-o:hor20,t:block-blinkon500-blinkoff500-TermCursor"
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.foldlevel = 99
-- vim.opt.foldlevelstart = 3
vim.opt.foldnestmax = 4
vim.opt.foldcolumn = "auto:1"
vim.opt.foldtext = "" -- replaced with treesitter-highlighted text

vim.opt.showmode = false

vim.opt.laststatus = 2
vim.opt.statuscolumn = "%s%=%l %C "
vim.opt.fillchars = {
    fold = " ",
    foldopen = "",
    foldclose = "",
    foldsep = " ",
    foldinner = " ",
}


vim.opt.colorcolumn = "80"

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.smarttab = true

-- LF Line terminators 
vim.opt.fileformat = 'unix'

vim.opt.exrc = true
vim.opt.undofile = true
vim.opt.autowriteall = true

vim.opt.spell = true
vim.opt.spelllang = { "en", "pl" }

local diffopt = {
    "internal",
    "filler",
    "closeoff",
    "indent-heuristic",
    "inline:char",
    "linematch:60",
}
vim.opt.diffopt = table.concat(diffopt, ",")
vim.cmd.packadd('nvim.difftool')

-- Default window locations
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Move chunks of text in visual mode
-- github.com/ThePrimeagen/neovimrc
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv")

vim.cmd.packadd('nvim.undotree')
vim.keymap.set("n", "<leader>u", vim.cmd.Undotree)

-- Appearance
vim.opt.termguicolors = true
vim.opt.winborder = "solid"
vim.cmd.colorscheme('custom')

-- Enables the experimental UI version (updates message and cmdline system)
-- g< opens the full output
require('vim._core.ui2').enable({})

require('config.clipboard')
require('config.plugins')
require('config.tabline')

vim.api.nvim_create_user_command('DiffOrig', function()
  local file = vim.fn.expand('%')
  vim.cmd('vert new')
  vim.cmd('set buftype=nofile | read ++edit ' .. file .. ' | 0d_ | diffthis')
  vim.cmd('wincmd p | diffthis')
end, { desc = 'Diff current unsaved buffer with file on disk' })

-- Highlight when yanking
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function ()
        vim.highlight.on_yank({ higroup = "Yank" })
    end
})

-- Close the associated location list before quitting a window
vim.api.nvim_create_autocmd("WinClosed", {
    desc = "Close location list when the parent window is closed",
    callback = function()
        if vim.bo.buftype ~= "quickfix" then
            pcall(vim.cmd.lclose)
        end
    end,
})

-- -- Automatically write class declaration boilerplate for empty java files
-- vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
--     pattern = "*.java",
--     callback = function (opts)
--         local lines = vim.api.nvim_buf_get_lines(opts.buf, 0, -1, false)
--         local file_empty = #lines == 0 or (#lines == 1 and lines[1] == "")
--         if not file_empty then return end
--
--         local luasnip = require("luasnip")
--         local java_snippets = luasnip.get_snippets("java")
--         luasnip.snip_expand(java_snippets[1], {pos = {0, 0}}) -- package
--
--         -- lines = vim.api.nvim_buf_get_lines(opts.buf, 0, -1, false)
--         -- luasnip.snip_expand(java_snippets[2], {pos = {#lines - 1, 0}}) -- class
--     end
-- })

vim.api.nvim_create_user_command("Format", "lua vim.lsp.buf.format()", {})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "gitcommit",
    callback = function ()
        vim.opt_local.textwidth = 72
    end
})
vim.api.nvim_create_user_command("Path",
    function()
        print(vim.fn.expand('%'))
    end,
    {}
)
