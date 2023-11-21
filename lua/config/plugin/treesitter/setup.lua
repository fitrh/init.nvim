local config = require("nvim-treesitter.configs")

config.setup({
  ensure_installed = {
    "astro",
    "bash",
    "bibtex",
    "c",
    "cmake",
    "comment",
    "cpp",
    "css",
    "c_sharp",
    "dart",
    "diff",
    "dockerfile",
    "fennel",
    "fish",
    "git_rebase",
    "gitcommit",
    "gitignore",
    "go",
    "gomod",
    "gosum",
    "gowork",
    "graphql",
    "html",
    "htmldjango",
    "ini",
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
    "phpdoc",
    "python",
    "query",
    "regex",
    "rust",
    "scfg",
    "scheme",
    "scss",
    "ssh_config",
    "sql",
    "svelte",
    "toml",
    "tsx",
    "typescript",
    "v",
    "vim",
    "vimdoc",
    "vue",
    "yaml",
    "zig",
  },
  highlight = { enable = true },
  incremental_selection = {
    enable = true,
    -- SEE: https://github.com/nvim-treesitter/nvim-treesitter/issues/4945
    -- SEE: https://github.com/UserNobody14/tree-sitter-dart/issues/48
    disable = { "dart" },
    keymaps = {
      init_selection = false,
      node_incremental = "g)",
      scope_incremental = "g}",
      node_decremental = "g(",
    },
  },
  indent = {
    enable = true,
    disable = { "dart" },
  },

  -- extra modules

  -- nvim-treesitter-textobjects
  textobjects = {
    select = {
      enable = true,
      -- for `zig`, SEE: https://github.com/nvim-treesitter/nvim-treesitter-textobjects/issues/461
      disable = { "dart", "zig" },
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
