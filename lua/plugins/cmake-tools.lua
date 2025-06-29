return {
  'Civitasv/cmake-tools.nvim',
  opts = {
    cmake_build_directory = function()
      local osys = require('cmake-tools.osys')
      if osys.iswin32 then
        return 'build'
      end
      return 'build'
    end,
    build_options = { '-j8' },
    cmake_dap_configuration = {
      name = 'Launch',
      type = 'codelldb',
      request = 'launch',
      cwd = '${workspaceFolder}',
      stopOnEntry = false,
      args = {},
      runInTerminal = false,
      initCommands = {
        "breakpoint set --name main",
      },
    }
  },
}
