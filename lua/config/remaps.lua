-- Set our leader key for each of the commands
vim.g.leader = ' '

-- Setup all of the remaps that I want to use with nvim
vim.keymap.set('n', '<leader>w', vim.cmd.w)
vim.keymap.set('n', '<leader>e', require'oil'.open)
vim.keymap.set('n', '<leader>x', vim.cmd.q)

-- LSP Settings
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>lc', vim.lsp.buf.code_action)
vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename)
vim.keymap.set('n', '<leader>li', vim.lsp.buf.hover)
vim.keymap.set('n', '<leader>ld', vim.lsp.buf.definition)
vim.keymap.set('n', '<leader>le', vim.diagnostic.open_float)
vim.keymap.set('i', '<C-space>', '<C-x><C-o>')

-- Debug Settings
local function is_rust_project()
  return vim.fn.filereadable("Cargo.toml") == 1
end

local function hybrid(map, rust_fn, cmake_cmd)
  vim.keymap.set('n', map, function()
    if is_rust_project() then
      rust_fn()
    else
      vim.cmd(cmake_cmd)
    end
  end)
end

hybrid('<leader>bb', function() vim.cmd("!cargo build") end, 'CMakeBuild')
hybrid('<leader>br', function() vim.cmd("!cargo run") end, 'CMakeRun')
hybrid('<leader>bd', function() require("dap").continue() end,        'CMakeDebug')
hybrid('<leader>bg', function() print("No CMake generate in Rust") end, 'CMakeGenerate')
hybrid('<leader>bt', function() vim.cmd("!cargo test") end, 'CMakeRunTest')
hybrid('<leader>bc', function() vim.cmd("!cargo clean") end, 'CMakeClean')
hybrid('<leader>bs', function() print("No build target selection for Rust") end, 'CMakeSelectBuildTarget')

-- Package Managers
vim.keymap.set('n', '<leader>pl', vim.cmd.Lazy)
vim.keymap.set('n', '<leader>pm', vim.cmd.Mason)

-- Debug Settings (I'm using s because I think I'll delete stuff on accident if I bind to d)
local dap, dapui = require('dap'), require('dapui')
vim.keymap.set('n', '<leader>so', dapui.open)
vim.keymap.set('n', '<leader>sb', dap.toggle_breakpoint)
vim.keymap.set('n', '<leader>sc', dap.continue)
vim.keymap.set('n', '<leader>ss', dap.step_over)
vim.keymap.set('n', '<leader>se', dap.step_out)
vim.keymap.set('n', '<leader>si', dap.step_into)
vim.keymap.set('n', '<leader>st', dap.terminate)

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
vim.keymap.set('n', '<leader>fa', builtin.find_files)
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
vim.keymap.set('n', '<leader>fc', function() marlin.remove_all() end, { desc = 'Marlin clear' })

for i = 1,9 do
  vim.keymap.set('n', '<leader>' .. i, function() marlin.open(i) end, { desc = 'Marlin open #' .. i })
end
