vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.numberwidth = 4

vim.opt.wrap = false

vim.opt.cursorline = true
vim.opt.cursorlineopt = 'line'
vim.opt.scrolloff = 999
-- Normal cursor but with a beam in the command line
vim.opt.guicursor = "n-v-sm:block,i-c-ci-ve:ver25-blinkon500,r-cr-o:hor20,t:block-blinkon500-blinkoff500-TermCursor"

-- Use 4 spaces as tab, 4 if not at the beginning of a line
-- I think treesitter overwrites it on supported filetypes
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.smarttab = true

-- LF Line terminators 
vim.opt.fileformat = 'unix'

-- Default window locations
vim.opt.splitbelow = true
vim.opt.splitright = true

-- TODO: Change the color to something defined by colorschemes
-- vim.cmd('highlight SignColumn guifg=red')

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Alt+hjkl in command mode
vim.keymap.set({"c"}, "<M-h>", "<Left>")
vim.keymap.set({"c"}, "<M-H>", "<S-Left>")
vim.keymap.set({"c"}, "<M-l>", "<Right>")
vim.keymap.set({"c"}, "<M-L>", "<S-Right>")
vim.keymap.set({"c"}, "<M-j>", "<Down>")
vim.keymap.set({"c"}, "<M-k>", "<Up>")

require('config.clipboard')
require('config.lazy')

-- Treesitter configuration
local treesitter_langs = {
    'c', 'make', 'cpp',

    'python',
    'lua',

    'typst',
    'markdown',

    'javascript', 'jsdoc',

    'json', 'csv',
    'yaml', 'toml', 'ini',

    'html', 'css',

    'bash',
    'tmux',
    'gitignore',

    'sql',
}
require('nvim-treesitter').install(treesitter_langs)
--
-- Enables treesitter features for installed parsers
vim.api.nvim_create_autocmd('FileType', {
    pattern = treesitter_langs,
    callback = function()
        vim.treesitter.start()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
}
)

vim.cmd("colorscheme default")
vim.cmd("set notermguicolors")
