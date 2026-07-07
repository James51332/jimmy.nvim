return {
  'tpope/vim-fugitive',
  lazy = false,
  dependencies = {
    { 'tpope/vim-rhubarb' },
  },
  keys = {
    { '<leader>gg', '<cmd>Git<cr>',           desc = 'Open Git' },
    { '<leader>gd', '<cmd>Git diff<cr>',      desc = 'Open Git diff' },
    { '<leader>gb', '<cmd>GBrowse<cr>',       desc = 'Open file in repo' },
    { '<leader>gm', '<cmd>Git mergetool<cr>', desc = 'Open merge tool' },
  }
}
