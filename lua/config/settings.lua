-- Setup basic settings about nvim
local opt = vim.opt

-- Enable line numbering
opt.rnu = true
opt.number = true

-- Set desired tab settings
opt.et = true
opt.shiftwidth = 2
opt.smarttab = true
opt.cinoptions = opt.cinoptions + 't0'

-- Misc settings
opt.formatoptions = 'tcqn' 
vim.cmd('autocmd BufEnter * set formatoptions-=cro')
vim.cmd('autocmd BufEnter * setlocal formatoptions-=cro')
opt.signcolumn = 'yes:2'

-- Setup oil.nvim
require('oil').setup({
  delete_to_trash = true,
  skip_confirm_for_simple_edits = true,
})

-- Setup telescope to ignore vendor stuff
require('telescope').setup({defaults = {
  file_ignore_patterns = { '/.git/', '/out/', '/build/', '/thirdparty/', '^.git/', '^out/', '^build/', '^thirdparty/' }
}})
