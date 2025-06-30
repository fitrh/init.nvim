local config = require("nvim-treesitter.configs")
local parser = require("nvim-treesitter.parsers").get_parser_configs()

-- TODO: Remove, upstreamed. SEE: https://github.com/nvim-treesitter/nvim-treesitter/pull/7693
parser.blade = {
  install_info = {
    url = "https://github.com/EmranMR/tree-sitter-blade",
    files = { "src/parser.c" },
    branch = "main",
  },
  filetype = "blade",
}

parser.plantuml = {
  install_info = {
    url = "https://github.com/cathaysia/tree-sitter-plantuml",
    files = { "src/parser.c" },
    branch = "master",
  },
  filetype = "plantuml",
}

config.setup({
  ensure_installed = {
    "astro",
    "bash",
    "bibtex",
    "blade",
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
    "git_config",
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
    "luadoc",
    "luap",
    "make",
    "markdown",
    "markdown_inline",
    "meson",
    "ninja",
    "php",
    "php_only",
    "phpdoc",
    "plantuml",
    "python",
    "query",
    "regex",
    "rust",
    "scala",
    "scfg",
    "scheme",
    "scss",
    "ssh_config",
    "sql",
    "svelte",
    "tmux",
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
  indent = { enable = true },

  -- extra modules

  -- nvim-treesitter-textobjects
  textobjects = {
    select = {
      enable = true,
      -- for `zig`, SEE: https://github.com/nvim-treesitter/nvim-treesitter-textobjects/issues/461
      disable = { "dart", "zig" },
      lookahead = true,
      keymaps = {
        ["aA"] = "@assignment.outer",
        ["iA"] = "@assignment.inner",
        ["aa"] = "@attribute.outer",
        ["ia"] = "@attribute.inner",
        ["aP"] = "@parameter.outer",
        ["iP"] = "@parameter.inner",
        ["aB"] = "@block.outer",
        ["iB"] = "@block.inner",
        ["ic"] = "@conditional.inner",
        ["ac"] = "@conditional.outer",
        ["ii"] = "@call.inner", -- i for invoke
        ["ai"] = "@call.outer",
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
        ["iS"] = "@statement.inner",
        ["aS"] = "@statement.outer",
        ["aC"] = "@class.outer",
        ["iC"] = "@class.inner",
        ["ar"] = "@return.outer",
        ["ir"] = "@return.inner",
      },
    },
    lsp_interop = {
      enable = true,
      floating_preview_opts = { border = "solid" },
      peek_definition_code = {
        ["gKf"] = "@function.outer",
        ["gKc"] = "@class.outer",
      },
    },
  },

  -- nvim-treesitter-pairs
  pairs = {
    enable = true,
    disable = { "svelte" },
    highlight_pair_events = { "CursorHold" },
    highlight_self = false,
    fallback_cmd_normal = false,
    keymaps = {
      goto_partner = "g%",
    },
  },
})
