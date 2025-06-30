return {
  "themaxmarchuk/tailwindcss-colors.nvim",
  config = function()
    require("config.plugin.tailwindcss-colors.setup")
  end,
  event = { "LspAttach" },
}
