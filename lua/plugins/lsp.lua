return {
  'mason-org/mason-lspconfig.nvim',
  lazy = false,
  dependencies = {
    {
      'mason-org/mason.nvim',
      opts = {},
      keys = { { '<leader>pm', '<cmd>Mason<cr>', desc = 'Open Mason' } },
    },
    'neovim/nvim-lspconfig',
    {
      'saghen/blink.cmp',
      version = '1.x',
      opts = { completion = { documentation = { auto_show = true } } },
    },
  },
  opts = {
    ensure_installed = {
      'lua_ls',
      'rust_analyzer',
      'clangd',
      'basedpyright',
      'ts_ls',
      'wgsl_analyzer',
    },
  },
  keys = {
    { '<leader>lf', vim.lsp.buf.format,         desc = 'LSP format' },
    { '<leader>li', vim.lsp.buf.hover,          desc = 'LSP hover' },
    { '<leader>lr', vim.lsp.buf.rename,         desc = 'LSP rename' },
    { '<leader>le', vim.diagnostic.open_float,  desc = 'LSP error' },
    { '<leader>ld', vim.lsp.buf.definition,     desc = 'LSP definition' },
    { '<leader>lj', vim.lsp.buf.implementation, desc = 'LSP implementation' },
    { '<leader>ls', vim.lsp.buf.references,     desc = 'LSP references' },
  },
  config = function(_, opts)
    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = '*',
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })

    require('mason-lspconfig').setup(opts)
  end,
}
