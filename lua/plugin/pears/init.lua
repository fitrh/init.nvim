return {
  "steelsojka/pears.nvim",
  after = "nvim-treesitter",
  config = function() require("plugin.pears.config") end,
  event = "InsertCharPre",
}
