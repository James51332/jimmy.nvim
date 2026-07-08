return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'master',
  build = ':TSUpdate',
  lazy = false,
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = { 'wgsl' },
      highlight = { enable = true },
    })
  end,
}
