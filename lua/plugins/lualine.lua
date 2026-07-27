return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-mini/mini.icons',
    {
      'kiennt63/harpoon-files.nvim',
      dependencies = {
        { 'ThePrimeagen/harpoon', branch = 'harpoon2' },
      }
    }
  },
  config = function()
    require('lualine').setup({
      sections = {
        lualine_c = { 'filename', require('harpoon_files').lualine_component }
      }
    })
  end,
}
