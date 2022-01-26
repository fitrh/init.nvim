return {
  "nvim-lualine/lualine.nvim",
  requires = {
    { "kyazdani42/nvim-web-devicons" },
    { "arkav/lualine-lsp-progress", module = "lualine" },
  },
  config = function()
    require("plugin.lualine.config")
  end,
  event = { "BufReadPost", "BufNewFile" },
  module = "lualine",
}
