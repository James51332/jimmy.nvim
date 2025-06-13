return {
  "Civitasv/cmake-tools.nvim",
  opts = {
    cmake_build_directory = function()
      local osys = require("cmake-tools.osys")
      if osys.iswin32 then
        return "build\\${variant:buildType}"
      end
      return "build/${variant:buildType}"
     end,
  },
}
