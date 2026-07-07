-- Leader
vim.g.mapleader = ' '
vim.g.localmapleader = '\\'

-- Write files
vim.keymap.set('n', '<leader>w', vim.cmd.w)

-- Preserve selection when shifting lines
vim.keymap.set('v', '<', '< gv')
vim.keymap.set('v', '>', '> gv')

-- Selection movement
vim.keymap.set({ 'n', 'i' }, '<C-j>', '<C-n>')
vim.keymap.set({ 'n', 'i' }, '<C-k>', '<C-p>')

-- Window management
vim.keymap.set('n', '<leader>q', vim.cmd.q)
