return {
  "hrsh7th/nvim-cmp",
  requires = {
    { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
    { "hrsh7th/cmp-path", after = "nvim-cmp" },
    { "hrsh7th/cmp-nvim-lua", ft = "lua" },
    { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
    { "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp-document-symbol", after = "nvim-cmp" },
    { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
    { "L3MON4D3/LuaSnip", module = "luasnip" },
    { "rafamadriz/friendly-snippets", event = { "BufRead" } },
  },
  config = function()
    require("config.plugin.cmp.setup")
  end,
  event = { "InsertEnter", "CmdlineEnter" },
}
