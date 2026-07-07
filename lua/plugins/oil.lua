return {
  'stevearc/oil.nvim',
  lazy = false,
  opts = {
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
  },
  dependencies = {
    {
      'nvim-mini/mini.icons',
      opts = {}
    },
  },
  keys = {
    { '<leader>e', '<cmd>Oil<cr>', desc = 'Open Oil' },
  },
}
