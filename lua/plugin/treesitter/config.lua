local conf = require("nvim-treesitter.configs")

conf.setup({
  ensure_installed = "maintained",
  highlight = { enable = true },
  autopairs = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-n>",
      node_incremental = "<Enter>",
      scope_incremental = "<A-Enter>",
      node_decremental = "<BS>",
    },
  },
  indent = { enable = true },
  refactor = {
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = "grr",
      }
    },
    navigation = {
      enable = true,
      keymaps = {
        goto_definition = "gnd",
        list_definitions = "gnD",
        list_definitions_toc = "gO",
        goto_next_usage = "<A-*>",
        goto_previous_usage = "<A-#>",
      },
    }
  },
})
