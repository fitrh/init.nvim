return {
  "windwp/nvim-autopairs",
  config = function()
    require("config.plugin.autopairs.setup")
  end,
  event = "InsertEnter",
}
