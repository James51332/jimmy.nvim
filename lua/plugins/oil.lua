return {
  'stevearc/oil.nvim',
  lazy = false,
  dependencies = {
    {
      "nvim-mini/mini.icons",
      opts = {}
    },
  },
  opts = {
    skip_confirm_for_simple_edits = false,
  },
  keys = {
    { '<leader>e', '<cmd>Oil<cr>', desc = 'Open Oil' },
  },
}
