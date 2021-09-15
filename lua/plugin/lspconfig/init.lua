local M = {
  "neovim/nvim-lspconfig",
  config = function()
    require("plugin.lspconfig.config")
  end,
  event = { "BufReadPre", "BufWritePost", "BufNewFile" },
}

return M
