-- Clipboard setup for WSL
if (vim.fn.getenv("WSL_DISTRO_NAME") ~= "") then
    vim.g.clipboard = {
        name = 'win32yank-wsl',
        copy = {
            ['+'] = 'win32yank.exe -i --crlf',
            ['*'] = 'win32yank.exe -i --crlf',
        },
        paste = {
            ['+'] = 'win32yank.exe -o --lf',
            ['*'] = 'win32yank.exe -o --lf',
        },
        cache_enabled = 0,
    }
end

-- prefix clipboard operation with leader to copy to system clipboard
vim.keymap.set('v', '<leader>y', '"+y', { desc = "Yank (system clipboard)" })
vim.keymap.set('v', '<leader>x', '"+x', { desc = "Cut character (system clipboard)" })
vim.keymap.set('n', '<leader>yy', '"+yy', { desc = "Yank line (system clipboard)" })
vim.keymap.set({ 'v', 'n' }, '<leader>p', '"+p', { desc = "Paste after cursor (system clipboard)" })
vim.keymap.set({ 'v', 'n' }, '<leader>P', '"+P', { desc = "Paste before cursor (system clipboard)" })


