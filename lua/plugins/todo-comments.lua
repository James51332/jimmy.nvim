return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  lazy = false,
  config = function()
    require("todo-comments").setup({
      highlight = {
        XXX = { keyword = "", after = "" },
      },
      keywords = {
        -- Define only what you want to see. 
        -- Since we muted XXX globally, omitting it here keeps it invisible.
        TODO = { icon = " ", color = "info" },
        FIXME = { icon = " ", color = "error" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
      },
      merge_keywords = false, 
      highlight = {
        keyword = "bg",
        pattern = [[.*<(KEYWORDS)\s*]], -- pattern or table of patterns, used for highlighting (vim regex)
      },
      search = {
        pattern = [[\b(KEYWORDS)]]
      },
    })
  end,
}
