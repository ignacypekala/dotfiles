local copy = require('vim.ui.clipboard.osc52').copy
local paste = require('vim.ui.clipboard.osc52').paste
if (vim.fn.getenv("WSL_DISTRO_NAME") ~= "") then
    vim.g.clipboard = {
        name = 'OSC 52',
        copy = {
            ['+'] = copy('+'),
            ['*'] = copy('*'),
        },
        paste = {
            ['+'] = paste('+'),
            ['*'] = paste('*'),
        },
    }
end

-- prefix clipboard operation with leader to copy to system clipboard
vim.keymap.set('v', '<leader>y', '"*y', { desc = "Yank (system clipboard)" })
vim.keymap.set('v', '<leader>x', '"*x', { desc = "Cut character (system clipboard)" })
vim.keymap.set({ 'v', 'n' }, '<leader>p', '"*p', { desc = "Paste after cursor (system clipboard)" })

-- vim.keymap.set('n', '<leader>yy', '"+yy', { desc = "Yank line (system clipboard)" })
-- vim.keymap.set({ 'v', 'n' }, '<leader>P', '"+P', { desc = "Paste before cursor (system clipboard)" })
