return {
  "folke/todo-comments.nvim",
  after = "nvim-treesitter",
  config = function()
    require("plugin.todo-comments.config")
  end,
}