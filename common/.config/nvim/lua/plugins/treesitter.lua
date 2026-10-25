return {
    "nvim-treesitter",
    lazy = false,
    priority = 100,
    before = function()
        vim.cmd.packadd("nvim-treesitter-context")
    end,
    after = function()
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

        local ts = require('nvim-treesitter')
        if ts.install then
            ts.install(treesitter_langs)
        elseif pcall(require, 'nvim-treesitter.install') then
            pcall(require('nvim-treesitter.install').ensure_installed, treesitter_langs)
        end

        vim.api.nvim_create_autocmd('FileType', {
            pattern = treesitter_langs,
            callback = function(args)
                vim.treesitter.start()
                if args.match == 'c' or args.match == 'cpp' then
                    vim.bo.cindent = true
                else
                    vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
                end
                vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
                vim.wo.foldmethod = "expr"
            end,
        })

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
    end
}
