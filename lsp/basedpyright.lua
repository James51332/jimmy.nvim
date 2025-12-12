return {
  cmd = { "basedpyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "pyrightconfig.json", "setup.cfg", "requirements.txt" },

  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = "off",           -- "off" disables type-checking entirely
        diagnosticMode = "openFilesOnly",   -- optional
        useLibraryCodeForTypes = true,      -- optional
      },
    },
  },

  on_attach = function(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    end
  end,
}
