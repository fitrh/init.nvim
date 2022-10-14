return {
  "nvim-lualine/lualine.nvim",
  requires = {
    { "kyazdani42/nvim-web-devicons", module = "nvim-web-devicons" },
  },
  config = function()
    require("config.plugin.lualine.setup")
  end,
  event = "ColorScheme",
}
