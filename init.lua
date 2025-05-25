-- Include our other settings
require("config.lazy")
require("config.remaps")
require("config.settings")
require("config.hardmode")

-- Setup LSP
vim.lsp.enable("clangd")
