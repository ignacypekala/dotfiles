
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.numberwidth = 4

vim.opt.wrap = false

vim.opt.cursorline = true
vim.opt.cursorlineopt = 'both'
vim.opt.scrolloff = 999
-- Normal cursor but with a beam when typing
vim.opt.guicursor = "n-v-sm:block,i-c-ci-ve:ver25-blinkon500,"..
    "r-cr-o:hor20,t:block-blinkon500-blinkoff500-TermCursor"
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.colorcolumn = "80"

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

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- alt+hjkl in command mode
-- Currently not used as i have the same overwrites in alacritty config
-- Leaving this just in case I switch terminal emulators
vim.keymap.set({"c"}, "<m-h>", "<left>")
vim.keymap.set({"c"}, "<m-h>", "<s-left>")
vim.keymap.set({"c"}, "<m-l>", "<right>")
vim.keymap.set({"c"}, "<m-l>", "<s-right>")
vim.keymap.set({"c"}, "<m-j>", "<down>")
vim.keymap.set({"c"}, "<m-k>", "<up>")

-- Move chunks of text in visual mode
-- github.com/ThePrimeagen/neovimrc
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv")

-- Appearance
vim.opt.termguicolors = false
vim.opt.winborder = "none"
vim.cmd.colorscheme('custom')

require('config.clipboard')
require('config.lazy')

-- Treesitter configuration
local treesitter_langs = {
    'c', 'make', 'cpp',
    'python','lua',
    'typst', 'markdown',
    'javascript', 'jsdoc',
    'json', 'csv',
    'yaml', 'toml', 'ini',
    'html', 'css',
    'bash',
    'tmux',
    'gitignore',
    'vimdoc',
    'sql',
}
require('nvim-treesitter').install(treesitter_langs)

-- Enables treesitter features for installed parsers
vim.api.nvim_create_autocmd('FileType', {
    pattern = treesitter_langs,
    callback = function(args)
        vim.treesitter.start()

        if args.match == 'c' or args.match == 'cpp' then
            vim.bo.cindent = true
        else
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
    end,
}
)

