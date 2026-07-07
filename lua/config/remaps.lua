-- Leader
vim.g.mapleader = ' '
vim.g.localmapleader = '\\' 

-- Write files
vim.keymap.set('n', '<leader>w', vim.cmd.w)

-- Window management
vim.keymap.set('n', '<leader>x', vim.cmd.q)
