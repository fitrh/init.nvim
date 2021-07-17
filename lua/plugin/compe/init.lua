local M = {
  "hrsh7th/nvim-compe",
  requires = {
    { "L3MON4D3/LuaSnip", event = "InsertCharPre" },
    { "ray-x/lsp_signature.nvim", module = "lsp_signature" },
  },
  config = function() require("plugin.compe.config") end,
  event = "InsertEnter",
}

return M
