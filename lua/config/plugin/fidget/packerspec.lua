return {
  "j-hui/fidget.nvim",
  config = function()
    require("config.plugin.fidget.setup")
  end,
  event = { "LspAttach" },
}
