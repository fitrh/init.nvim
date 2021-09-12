return {
  "hrsh7th/nvim-cmp",
  requires = {
    { "hrsh7th/cmp-buffer", after = "nvim-cmp", },
    { "hrsh7th/cmp-path", after = "nvim-cmp", },
    { "hrsh7th/cmp-nvim-lua", ft = "lua", },
    { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp", },
    { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp", },
  },
  config = function () require("plugin.cmp.config") end,
  event = "InsertEnter",
  module = "cmp",
}
