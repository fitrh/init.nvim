local config = {}

config.progress = {
  display = {
    done_icon = "✓", -- digraph `OK`
    done_style = "DiagnosticOk",
    progress_style = "DiagnosticInfo",
    icon_style = "Number",
  },
}

config.notification = {
  view = {
    group_separator = "─────", -- digraph `hh`
  },
}

require("fidget").setup(config)
