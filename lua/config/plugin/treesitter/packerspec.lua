return {
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("config.plugin.treesitter.setup")
    end,
    ft = {
      "astro",
      "bash",
      "bib",
      "c",
      "cmake",
      "cpp",
      "cs",
      "css",
      "dart",
      "diff",
      "dockerfile",
      "dosini",
      "fish",
      "fennel",
      "gitcommit",
      "gitignore",
      "gitrebase",
      "go",
      "gomod",
      "graphql",
      "help",
      "html",
      "htmldjango",
      "java",
      "javascript",
      "javascriptreact",
      "json",
      "jsonc",
      "kotlin",
      "lua",
      "make",
      "markdown",
      "meson",
      "ninja",
      "php",
      "python",
      "query",
      "rust",
      "scheme",
      "scss",
      "sh",
      "sql",
      "svelte",
      "tex",
      "toml",
      "typescript",
      "typescriptreact",
      "vim",
      "vlang",
      "vue",
      "yaml",
      "zig",
    },
    event = { "User TelescopePreviewerLoaded" },
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter",
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    after = "nvim-treesitter",
  },
  { "windwp/nvim-ts-autotag", after = "nvim-treesitter" },
}
