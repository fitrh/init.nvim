return {
  "lukas-reineke/headlines.nvim",
  config = function()
    require("config.plugin.headlines.setup")
  end,
  ft = { "markdown", "norg", "org" },
}
