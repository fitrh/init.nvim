return {
  "nvim-lualine/lualine.nvim",
  requires = {
    { "kyazdani42/nvim-web-devicons", module = "nvim-web-devicons" },
  },
  config = function()
    require("plugin.lualine.config")
  end,
  event = "ColorScheme",
  module = "lualine",
}
