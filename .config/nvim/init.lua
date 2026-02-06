vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.numberwidth = 4

vim.opt.wrap = false

vim.opt.cursorline = true
vim.opt.cursorlineopt = 'line'
vim.opt.scrolloff = 999


-- Use 4 spaces as tab, 4 if not at the beginning of a line
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

require('config.clipboard')
require('config.lazy')

-- Treesitter configuration
local treesitter_langs = { 
    'c', 
    'python', 
    'typst', 
    'markdown', 
    'make', 
    'javascript', 
    'jsdoc', 
    'json', 
    'html', 
    'css',
    'csv', 
    'lua', 
    'bash', 
    'make' 
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

-- Configure emulated terminal
vim.keymap.set('n', '<leader>t', '<CMD>botright 15split<CR><CMD>terminal<CR>',
    { desc = 'Opens a small terminal from the bottom' })
vim.api.nvim_create_autocmd('TermOpen', {
    group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
    callback = function()
        vim.opt.number = true
        vim.opt.relativenumber = true
    end
})
vim.keymap.set('t', '<Esc>', "<C-\\><C-n>", { desc = "Exit terminal mode" })
