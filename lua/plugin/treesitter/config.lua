local conf = require("nvim-treesitter.configs")

conf.setup({
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
    "php",
    "python",
    "query",
    "rasi",
    "regex",
    "rust",
    "scss",
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
      node_incremental = "<CR>",
      scope_incremental = "<S-CR>",
      node_decremental = "<BS>",
    },
  },
  indent = { enable = true },

  -- extra modules

  -- nvim-treesitter-refactor
  refactor = {
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = "grr",
      },
    },
    navigation = {
      enable = true,
      keymaps = {
        goto_definition = "gnd",
        list_definitions = "gnD",
        list_definitions_toc = "gO",
        goto_next_usage = "]u",
        goto_previous_usage = "[u",
      },
    },
  },

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
