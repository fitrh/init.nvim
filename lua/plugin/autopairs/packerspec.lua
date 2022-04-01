return {
  "windwp/nvim-autopairs",
  config = function()
    require("plugin.autopairs.config")
  end,
  event = "InsertCharPre",
}
