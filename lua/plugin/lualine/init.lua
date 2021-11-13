return {
  "nvim-lualine/lualine.nvim",
  requires = { "kyazdani42/nvim-web-devicons" },
  config = function()
    require("plugin.lualine.config")
  end,
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  module = "lualine",
}
