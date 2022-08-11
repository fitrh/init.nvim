return {
  "gbprod/phpactor.nvim",
  requires = {
    { "nvim-lua/plenary.nvim", module = "plenary" },
    { "neovim/nvim-lspconfig", module = "lspconfig" },
  },
  config = function()
    require("phpactor").setup({
      lspconfig = require("config.lsp.server").with("phpactor"),
    })
  end,
  ft = "php",
}
