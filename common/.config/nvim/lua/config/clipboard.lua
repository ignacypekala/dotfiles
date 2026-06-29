-- Use OSC 52 for the clipboard
-- wezterm only supports writing so paste with ctrl+shift+v
vim.g.clipboard = 'osc52'

-- prefix clipboard operation with leader to interact with the system clipboard
vim.keymap.set({'v', 'n'}, '<leader>y', '"+y', {
    desc = "Yank (system clipboard)",
    noremap = true
})

vim.keymap.set({ 'v', 'n' }, '<leader>p', '"+p', {
    desc = "Paste after cursor (system clipboard)"
})
