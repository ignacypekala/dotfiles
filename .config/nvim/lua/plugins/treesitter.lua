local github = require("utils.pack_providers").github

vim.pack.add(
    { github.."nvim-treesitter/nvim-treesitter" }
)

local treesitter_langs = {
    'c', 'make', 'cpp',
    'asm',
    'python','lua',
    'typst', 'markdown',
    'javascript', 'jsdoc',
    'java',
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

vim.api.nvim_create_autocmd('FileType', {
    pattern = treesitter_langs,
    callback = function(args)
        vim.treesitter.start()
        if args.match == 'c' or args.match == 'cpp' then
            vim.bo.cindent = true
        else
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.wo.foldmethod = "expr"
    end,
}
)

