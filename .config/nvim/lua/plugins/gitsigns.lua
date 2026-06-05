local github = require("utils.pack_providers").github

vim.pack.add({github .. "lewis6991/gitsigns.nvim"})

require('gitsigns').setup{
    on_attach = function(bufnr)
        local gitsigns = require('gitsigns')

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
            if vim.wo.diff then
                vim.cmd.normal({']c', bang = true})
            else
                gitsigns.nav_hunk('next')
            end
        end)

        map('n', '[c', function()
            if vim.wo.diff then
                vim.cmd.normal({'[c', bang = true})
            else
                gitsigns.nav_hunk('prev')
            end
        end)

        -- Actions
        map('n', '<leader>ss', gitsigns.stage_hunk)
        map('n', '<leader>sr', gitsigns.reset_hunk)

        map('v', '<leader>ss', function()
            gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end)

        map('v', '<leader>sr', function()
            gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end)

        map('n', '<leader>sS', gitsigns.stage_buffer)
        map('n', '<leader>sR', gitsigns.reset_buffer)
        map('n', '<leader>sp', gitsigns.preview_hunk)
        map('n', '<leader>si', gitsigns.preview_hunk_inline)

        map('n', '<leader>sb', function()
            gitsigns.blame_line({ full = true })
        end)

        map('n', '<leader>sd', gitsigns.diffthis)

        map('n', '<leader>sD', function()
            gitsigns.diffthis('~')
        end)

        map('n', '<leader>sQ', function() gitsigns.setqflist('all') end)
        map('n', '<leader>sq', gitsigns.setqflist)

        -- Text object
        map({'o', 'x'}, 'ih', gitsigns.select_hunk)
    end
}
