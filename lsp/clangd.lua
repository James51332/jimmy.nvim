return {
  cmd = { "clangd" },
  filetypes = { "cpp", "c", "hpp", "h" },
  root_markers = { ".clangformat" },
  on_attach = function(client, bufnr)
    -- Enable formatting on save
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ async = false })  -- sync formatting
        end,
      })
    end
  end
}
