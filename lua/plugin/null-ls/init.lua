return {
  "jose-elias-alvarez/null-ls.nvim",
  requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  config = function()
    require("plugin.null-ls.config")
  end,
  ft = {
    "css",
    "fish",
    "gitcommit",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "lua",
    "markdown",
    "python",
    "scss",
    "sh",
    "svelte",
    "typescript",
    "typescriptreact",
    "vue",
    "yaml",
  },
}
