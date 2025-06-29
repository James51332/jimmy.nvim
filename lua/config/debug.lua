-- Here, we'll setup all of the plugins needed for debugging our CMake C++ projects.
local cmake, dap, mason, mason_dap, dapui = require 'cmake-tools', require 'dap', require 'mason', require 'mason-nvim-dap', require 'dapui'

-- Start by setting up mason package manager to install our needed debugger.
mason.setup()
mason_dap.setup({
  ensure_installed = { 'codelldb' },
  automatic_installation = true
})

-- Next, we'll setup dap with our usual configs.
dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = "codelldb",
    args = { "--port", "${port}" },
  },
}

-- We won't really use this to be honest, but it's nice to be able to select an executable. This
-- way we can debug a file if we so choose.
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
    runInTerminal = false,
  },
}

-- TODO Remove this
dap.set_log_level('TRACE')

-- Setup the DAP UI so we can step and whatnot.
dapui.setup()

-- Store the user's window and buffer state
local saved_state = {}

local function refocus_terminal()
  if vim.fn.has("macunix") == 1 then
    os.execute("osascript -e 'tell application \"kitty\" to activate'")
  end
end

function dap_open_ui()
  local win = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_get_current_buf()
  local view = vim.fn.winsaveview()
  saved_state = {
    win = win,
    buf = buf,
    view = view
  }

  dapui.open()
end

function dap_close_ui()
  dapui.close()
  dap.terminate()
  dap.close()

  if saved_state and saved_state.win and vim.api.nvim_win_is_valid(saved_state.win) then
    vim.api.nvim_set_current_win(saved_state.win)
  end
  if saved_state and saved_state.buf and vim.api.nvim_buf_is_valid(saved_state.buf) then
    vim.api.nvim_set_current_buf(saved_state.buf)
  end
  if saved_state and saved_state.view then
    vim.fn.winrestview(saved_state.view)
  end

  vim.defer_fn(function()
    refocus_terminal()
  end, 500)
end


dap.listeners.after.event_initialized['dapui_config'] = dap_open_ui
dap.listeners.before.event_terminated['dapui_config'] = dap_close_ui
dap.listeners.before.event_exited['dapui_config'] = dap_close_ui
dap.listeners.before.event_disconnected['dapui_config'] = dap_close_ui
