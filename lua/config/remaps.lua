-- Set our leader key for each of the commands
vim.g.leader = ' '

-- Setup all of the remaps that I want to use with nvim
vim.keymap.set('n', '<leader>w', vim.cmd.w)
vim.keymap.set('n', '<leader>e', require'oil'.open)

-- LSP Settings
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename)
vim.keymap.set('n', '<leader>ls', vim.lsp.buf.hover)
vim.keymap.set('n', '<leader>ld', vim.lsp.buf.definition)
vim.keymap.set('n', '<leader>le', vim.diagnostic.open_float)
vim.keymap.set('i', '<C-space>', '<C-x><C-o>')

-- CMake Settings
vim.keymap.set('n', '<leader>bb', vim.cmd.CMakeBuild)
vim.keymap.set('n', '<leader>br', vim.cmd.CMakeRun)
vim.keymap.set('n', '<leader>bd', vim.cmd.CMakeDebug)
vim.keymap.set('n', '<leader>bg', vim.cmd.CMakeGenerate)

-- Setup Marlin as our tool for switching files quickly
local mindex = 0
local generate_finder = function()
  mindex = 0
  return require("telescope.finders").new_table({
  results = require("marlin").get_indexes(),
    entry_maker = function(entry)
      mindex = mindex + 1
      return {
        value = entry,
        ordinal = mindex .. ":" .. entry.filename,
        lnum = entry.row,
        col = entry.col + 1,
        filename = entry.filename,
        display = mindex .. ":" .. entry.filename .. ":" .. entry.row .. ":" .. entry.col,
      }
    end,
  })
end

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>fb', builtin.buffers)
vim.keymap.set('n', '<leader>fg', builtin.live_grep)
vim.keymap.set("n", "<leader>ff", function()
  local conf = require("telescope.config").values
  local action_state = require("telescope.actions.state")

  require("telescope.pickers")
    .new({}, {
      prompt_title = "Marlin",
      finder = generate_finder(),
      previewer = conf.grep_previewer({}),
      sorter = conf.generic_sorter({}),
      attach_mappings = function(_, map)
        map("i", "<c-d>", function(bufnr)
          local current_picker = action_state.get_current_picker(bufnr)
          current_picker:delete_selection(function(selection)
            require("marlin").remove(selection.filename)
          end)
        end)

        map("i", "+", function(bufnr)
          local current_picker = action_state.get_current_picker(bufnr)
          local selection = current_picker:get_selection()
          require("marlin").move_up(selection.filename)
          current_picker:refresh(generate_finder(), {})
        end)
        map("i", "-", function(bufnr)
          local current_picker = action_state.get_current_picker(bufnr)
          local selection = current_picker:get_selection()
          require("marlin").move_down(selection.filename)
          current_picker:refresh(generate_finder(), {})
        end)
        return true
      end,
    })
    :find()
  end, { desc = "Telescope marlin" })

local marlin = require('marlin')
vim.keymap.set('n', '<leader>a', function() marlin.add() end, { desc = 'Marlin add' })
vim.keymap.set('n', '<leader>fx', function() marlin.remove() end, { desc = 'Marlin remove' })
vim.keymap.set('n', '<leader>fc', function() marlin.clear() end, { desc = 'Marlin clear' })

for i = 1,9 do
  vim.keymap.set('n', '<leader>' .. i, function() marlin.open(i) end, { desc = 'Marlin open #' .. i })
end
