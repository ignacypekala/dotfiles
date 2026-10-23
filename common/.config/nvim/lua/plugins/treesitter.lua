local github = require("utils.pack_providers").github

vim.pack.add(
    {
        github.."nvim-treesitter/nvim-treesitter",
        github.."nvim-treesitter/nvim-treesitter-context"
    }
)

local treesitter_langs = {
    'comment',
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
    'gitignore',
    'vimdoc',
    'sql',

    'nix', 'qmljs'
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

require("treesitter-context").setup({
    enable = true,
    max_lines = 3,
    min_window_height = 0,
    line_numbers = true,
    multiline_threshold = 20,
    trim_scope = 'outer',
    mode = 'cursor',
    separator = nil,
})
