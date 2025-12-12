-- Include our other settings
require("config.lazy")
require("config.settings")
require("config.remaps")
require("config.hardmode")
require("config.debug")

-- Setup LSP
vim.lsp.enable("clangd")
vim.lsp.enable("basedpyright")
vim.lsp.enable("typescript")
vim.lsp.enable("rust-analyzer")
