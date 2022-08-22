return {
  "folke/todo-comments.nvim",
  requires = {
    { "nvim-lua/plenary.nvim", module = "plenary" },
    { "nvim-treesitter/nvim-treesitter", module = "nvim-treesitter" },
    { "nvim-telescope/telescope.nvim", module = "telescope" },
    { "folke/trouble.nvim", module = "trouble" },
  },
  config = function()
    require("config.plugin.todo-comments.setup")
    require("config.plugin.todo-comments.keymap")
  end,
  keys = { "[t", "[l" },
}
