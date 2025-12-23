return {
  'desdic/marlin.nvim',
  config = function(_, opts)
    local marlin = require('marlin')
    marlin.setup(opts)
  end
}
