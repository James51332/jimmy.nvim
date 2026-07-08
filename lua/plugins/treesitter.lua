return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').install({
      'rust',
      'wgsl',
    })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = {
        'rust',
        'wgsl',
      },
      callback = function() vim.treesitter.start() end,
    })
  end,
}
