-- Setup basic settings about nvim
local opt = vim.opt

-- Enable line numbering
opt.rnu = true
opt.number = true

-- Set desired tab settings
opt.et = true
opt.shiftwidth=2

-- Misc settings 
opt.formatoptions = opt.formatoptions - "o"
opt.signcolumn = "yes:2"

-- Settings for NetRW
vim.g.netrw_bufsettings = 'noma nomod nu nowrap ro nobl'
