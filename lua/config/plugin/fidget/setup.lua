local config = {}

config.progress = {
  display = {
    done_icon = "✓",
  },
}

config.notification = {
  view = {
    group_separator = "─────", -- digraph `hh`
  },
}

require("fidget").setup(config)
