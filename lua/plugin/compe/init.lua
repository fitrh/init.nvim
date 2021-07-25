return {
  "hrsh7th/nvim-compe",
  requires = { "L3MON4D3/LuaSnip" },
  config = function() require("plugin.compe.config") end,
  event = "InsertEnter",
}
