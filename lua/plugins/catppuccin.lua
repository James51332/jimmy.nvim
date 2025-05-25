return { 
  'catppuccin/nvim', 
  name = 'catppuccin', 
  priority = 1000, 
  config = function()
    require'catppuccin'.setup({
      background = {
        light = 'latte',
        dark = 'macchiato',
      },
      term_colors = true,
      integrations = {
        telescope = true,
        mason = true,
        notify = true,
        mini = {
          enabled = true,
          indentscope_color = '',
        },
      },
    })
    vim.cmd.colorscheme 'catppuccin'
  end 
}
