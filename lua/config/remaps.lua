-- Set our leader key for each of the commands
vim.g.leader = ' '

-- Setup all of the remaps that I want to use with nvim
vim.keymap.set('n', '<leader>w', vim.cmd.w)
vim.keymap.set('n', '<leader>e', require'oil'.open)

-- LSP Settings
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename)
vim.keymap.set('n', '<leader>ls', vim.lsp.buf.hover)
vim.keymap.set('n', '<leader>ld', vim.lsp.buf.definition)
vim.keymap.set('n', '<leader>le', vim.diagnostic.open_float)
vim.keymap.set('i', '<C-space>', vim.lsp.omnifunc)

-- Fuzzy Finder
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
