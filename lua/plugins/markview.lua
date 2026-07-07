return {
  'OXY2DEV/markview.nvim',
  lazy = false,
  opts = {
    preview = {
      icon_provider = 'mini',
    },
  },
  dependencies = {
    {
      'nvim-mini/mini.icons',
      opts = {}
    },
  },
  keys = {
    { '<leader>mt', '<cmd>Markview toggle<cr>', desc = 'Toggle markdown preview' },
  },
}
