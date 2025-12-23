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
      custom_highlights = function(colors)
        return {
          -- This forces the legacy group and the modern TS group to look like comments
          rustTodo = { link = "Comment" },
          Todo = { link = "Comment" },
          ["@comment.todo"] = { link = "Comment" },
        }
      end,
    })
    
    vim.cmd.colorscheme 'catppuccin'
  end 
}
