local M = {}

M.devicons = {
  "kyazdani42/nvim-web-devicons",
  config = function()
    require("nvim-web-devicons").setup({ default = true })
  end,
  module = "nvim-web-devicons",
}

M.nonicons = {
  "yamatsum/nvim-nonicons",
  requires = { "kyazdani42/nvim-web-devicons" },
  module = "nvim-nonicons",
}

return M
