return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  lazy = false,
  dependencies = {
    'nvim-telescope/telescope.nvim',
    opts = true,
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    keys = {
      { '<leader>fa', function() require('telescope.builtin').find_files() end, desc = 'Telescope find files' },
      { '<leader>fg', function() require('telescope.builtin').live_grep() end,  desc = 'Telescope live grep' },
    },
  },
  opts = {
    settings = { save_on_close = true, }
  },
  keys = function()
    local harpoon_files = require('harpoon'):list()
    local harpoon_view = function()
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      local conf = require('telescope.config').values
      require('telescope.pickers').new({}, {
        prompt_title = 'Harpoon',
        finder = require('telescope.finders').new_table({
          results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
      }):find()
    end

    local keys = {
      { '<leader>ff', harpoon_view,                          desc = 'Telescope harpoon files' },
      { '<leader>a',  function() harpoon_files:add() end,    desc = 'Harpoon pin' },
      { '<leader>fx', function() harpoon_files:remove() end, desc = 'Harpoon unpin' },
      { '<leader>fc', function() harpoon_files:clear() end,  desc = 'Harpoon clear' },
    }
    for i = 1, 9 do
      table.insert(keys, {
        '<leader>' .. i,
        function()
          harpoon_files:select(i)
        end,
        desc = 'Harpoon file #' .. i
      })
    end

    return keys
  end,
}
