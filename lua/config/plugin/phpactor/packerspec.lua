return {
  "gbprod/phpactor.nvim",
  requires = {
    { "nvim-lua/plenary.nvim", module = "plenary" },
    { "neovim/nvim-lspconfig", module = "lspconfig" },
  },
  config = function()
    require("config.plugin.phpactor.setup")
    vim.api.nvim_exec_autocmds("FileType", {
      pattern = "php",
      modeline = false,
    })
  end,
  ft = "php",
}
