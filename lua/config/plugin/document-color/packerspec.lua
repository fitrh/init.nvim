return {
  "mrshmllow/document-color.nvim",
  config = function()
    require("config.plugin.document-color.setup")
  end,
  event = { "LspAttach" },
}
