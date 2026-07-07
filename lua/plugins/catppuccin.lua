return {
  'catppuccin/nvim',
  priority = 1000,
  opts = {
    integrations = { lualine = true },
  },
  config = function()
    vim.cmd.colorscheme('catppuccin-macchiato')
  end,
}
