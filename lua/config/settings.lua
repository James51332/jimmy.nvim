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

-- Setup oil.nim
require("oil").setup({
  delete_to_trash = true,
  skip_confirm_for_simple_edits = true,
})

