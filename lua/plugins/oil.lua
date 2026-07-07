return {
  'stevearc/oil.nvim',
  lazy = false,
  dependencies = { 
    { 
      "nvim-mini/mini.icons", 
      opts = {} 
    } 
  },
  opts = {},
  keys = {
    { 
      '<leader>e', 
      function() require('oil').open() end 
    },
  },
}
