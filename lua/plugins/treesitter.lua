return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      -- Use pcall (protected call) to prevent Neovim from crashing if things move
      local status, configs = pcall(require, "nvim-treesitter.configs")
      if not status then return end

      configs.setup({
        ensure_installed = { "c", "cpp", "python", "rust", "lua", "vim", "vimdoc", "comments" },
        highlight = {
          enable = true,
          -- This is what finally removes the XXX highlighting from old Vim
          additional_vim_regex_highlighting = false, 
        },
        indent = { enable = true }, -- Better indentation for Python/C++

      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "rust",
        callback = function()
          -- Clear the group that legacy Vim uses
          vim.cmd([[syntax clear rustTodo]])
          -- Safety: link the group to normal Comment color just in case it recreates itself
          vim.api.nvim_set_hl(0, "rustTodo", { link = "Comment" })
        end,
      })

      vim.api.nvim_set_hl(0, "Todo", { link = "Comment" })
      vim.api.nvim_set_hl(0, "@comment.todo", { link = "Comment" })
    end,
  },
}
