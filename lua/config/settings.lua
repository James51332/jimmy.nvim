-- Line number and tab
vim.opt.number = true
vim.opt.rnu = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- Use device clipboard for yank
vim.opt.clipboard = 'unnamedplus'

-- Disable neovim loading for languages
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
