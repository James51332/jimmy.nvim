-- Setup for CMake/C++ and Rust debugging
local cmake, dap, mason, mason_dap, dapui = require 'cmake-tools', require 'dap', require 'mason', require 'mason-nvim-dap', require 'dapui'

-- Mason setup to install codelldb
mason.setup()
mason_dap.setup({
  ensure_installed = { 'codelldb' },
  automatic_installation = true
})

-- Adapter
dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = "codelldb",
    args = { "--port", "${port}" },
  },
}

-- C++ configuration
dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'codelldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd(), 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = true,
    args = {},
    runInTerminal = true,
  },
}

-- Rust configuration
dap.configurations.rust = {
  {
    name = 'Rust Debug',
    type = 'codelldb',
    request = 'launch',
    program = function()
      -- Build with cargo and get executable
      local output = vim.fn.system("cargo build --message-format=json")
      local exe = output:match('%"executable%":%s*%"([^"]+)"')
      return exe or vim.fn.input('Path to Rust executable: ', vim.fn.getcwd(), 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false, 
    args = {},
    runInTerminal = true,
  },
}

-- Setup DAP UI
dapui.setup()

-- Save/restore user's window and buffer
local saved_state = {}
local function refocus_terminal()
  if vim.fn.has("macunix") == 1 then
    os.execute("osascript -e 'tell application \"kitty\" to activate'")
  end
end

local function dap_open_ui()
  saved_state.win = vim.api.nvim_get_current_win()
  saved_state.buf = vim.api.nvim_get_current_buf()
  saved_state.view = vim.fn.winsaveview()
  dapui.open()
end

local function dap_close_ui()
  dapui.close()
  dap.terminate()
  dap.close()
  if saved_state.win and vim.api.nvim_win_is_valid(saved_state.win) then
    vim.api.nvim_set_current_win(saved_state.win)
  end
  if saved_state.buf and vim.api.nvim_buf_is_valid(saved_state.buf) then
    vim.api.nvim_set_current_buf(saved_state.buf)
  end
  if saved_state.view then
    vim.fn.winrestview(saved_state.view)
  end
  vim.defer_fn(refocus_terminal, 500)
end

-- Listeners for all sessions (C++ & Rust UI open/close)
dap.listeners.after.event_initialized['dapui_config'] = dap_open_ui
dap.listeners.before.event_terminated['dapui_config'] = dap_close_ui
dap.listeners.before.event_exited['dapui_config'] = dap_close_ui
dap.listeners.before.event_disconnected['dapui_config'] = dap_close_ui

-- Keybinds
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

