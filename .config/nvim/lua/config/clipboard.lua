
local copy = '/mnt/c/Windows/System32/clip.exe'
local paste = '/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))'

-- Clipboard setup for WSL
if (vim.fn.getenv("WSL_DISTRO_NAME") ~= "") then
    vim.g.clipboard = {
        name = 'win32yank-wsl',
        copy = {
            ['+'] = copy,
            ['*'] = copy,
        },
        paste = {
            ['+'] = paste,
            ['*'] = paste,
        },
        cache_enabled = 0,
    }
end

-- prefix clipboard operation with leader to copy to system clipboard
vim.keymap.set('v', '<leader>y', '"+y', { desc = "Yank (system clipboard)" })
vim.keymap.set('v', '<leader>x', '"+x', { desc = "Cut character (system clipboard)" })
vim.keymap.set({ 'v', 'n' }, '<leader>p', '"+p', { desc = "Paste after cursor (system clipboard)" })

-- vim.keymap.set('n', '<leader>yy', '"+yy', { desc = "Yank line (system clipboard)" })
-- vim.keymap.set({ 'v', 'n' }, '<leader>P', '"+P', { desc = "Paste before cursor (system clipboard)" })


