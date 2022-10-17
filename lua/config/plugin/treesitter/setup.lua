local config = require("nvim-treesitter.configs")

config.setup({
  ensure_installed = {
    "bash",
    "bibtex",
    "c",
    "cmake",
    "comment",
    "cpp",
    "css",
    "c_sharp",
    "dart",
    "dockerfile",
    "fish",
    "go",
    "gomod",
    "gowork",
    "graphql",
    "html",
    "java",
    "javascript",
    "jsdoc",
    "json",
    "jsonc",
    "kotlin",
    "latex",
    "lua",
    "make",
    "markdown",
    "markdown_inline",
    "meson",
    "ninja",
    "php",
    "python",
    "query",
    "regex",
    "rust",
    "scheme",
    "scss",
    "sql",
    "svelte",
    "toml",
    "tsx",
    "typescript",
    "v",
    "vim",
    "vue",
    "yaml",
    "zig",
  },
  highlight = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      node_incremental = "g)",
      scope_incremental = "g}",
      node_decremental = "g(",
    },
  },
  indent = { enable = true },

  -- extra modules

  -- nvim-treesitter-textobjects
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["aB"] = "@block.outer",
        ["iB"] = "@block.inner",
        ["ic"] = "@conditional.inner",
        ["ac"] = "@conditional.outer",
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
        ["is"] = "@statement.inner",
        ["as"] = "@statement.outer",
        ["aC"] = "@class.outer",
        ["iC"] = "@class.inner",
      },
    },
  },

  -- nvim-ts-context-commentstring
  context_commentstring = { enable = true },

  -- nvim-ts-autotag
  autotag = { enable = true },
})
