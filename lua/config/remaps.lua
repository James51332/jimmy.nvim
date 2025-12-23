-- Leader Key
vim.g.leader = ' '

-- Basic Keybinds
local oil = require 'oil'
vim.keymap.set('n', '<leader>w', vim.cmd.w)
vim.keymap.set('n', '<leader>e', oil.open)
vim.keymap.set('n', '<leader>x', vim.cmd.q)

-- Keep text highlighted for changing indentation.
vim.keymap.set('v', '<', '< gv')
vim.keymap.set('v', '>', '> gv')

-- LSP Settings
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>lc', vim.lsp.buf.code_action)
vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename)
vim.keymap.set('n', '<leader>li', vim.lsp.buf.hover)
vim.keymap.set('n', '<leader>ld', vim.lsp.buf.definition)
vim.keymap.set('n', '<leader>le', vim.diagnostic.open_float)
vim.keymap.set('i', '<C-space>', '<C-x><C-o>')

-- Debug Settings (Use s b/c it's safer than d)
local dap, dapui = require('dap'), require('dapui')
vim.keymap.set('n', '<leader>so', dapui.open)
vim.keymap.set('n', '<leader>sb', dap.toggle_breakpoint)
vim.keymap.set('n', '<leader>sc', dap.continue)
vim.keymap.set('n', '<leader>ss', dap.step_over)
vim.keymap.set('n', '<leader>se', dap.step_out)
vim.keymap.set('n', '<leader>si', dap.step_into)
vim.keymap.set('n', '<leader>st', dap.terminate)

-- Package Managers
vim.keymap.set('n', '<leader>pl', vim.cmd.Lazy)
vim.keymap.set('n', '<leader>pm', vim.cmd.Mason)

-- Fuzzy Finder
local marlin = require('marlin')
vim.keymap.set('n', '<leader>a', function() marlin.add() end, { desc = 'Marlin add' })
vim.keymap.set('n', '<leader>fx', function() marlin.remove() end, { desc = 'Marlin remove' })
vim.keymap.set('n', '<leader>fc', function() marlin.remove_all() end, { desc = 'Marlin clear' })

for i = 1,9 do
  vim.keymap.set('n', '<leader>' .. i, function() marlin.open(i) end, { desc = 'Marlin open #' .. i })
end
