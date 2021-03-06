return {
  "jose-elias-alvarez/null-ls.nvim",
  requires = { "nvim-lua/plenary.nvim" },
  config = function()
    require("config.plugin.null-ls.setup")
  end,
  ft = {
    "c",
    "cpp",
    "css",
    "django",
    "fish",
    "gitcommit",
    "gitrebase",
    "go",
    "gomod",
    "haskell",
    "html",
    "htmldjango",
    "javascript",
    "javascriptreact",
    "json",
    "kotlin",
    "lua",
    "markdown",
    "php",
    "python",
    "scss",
    "sh",
    "svelte",
    "txt",
    "typescript",
    "typescriptreact",
    "vue",
  },
}
