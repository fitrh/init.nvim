return {
  "windwp/nvim-autopairs",
  requires = { "hrsh7th/nvim-compe" },
  config = function() require("plugin.autopairs.config") end,
  event = "InsertCharPre",
}
