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
  window = {
    -- normal_hl = "NormalFloat",
    winblend = 0,
    -- border = "solid",
    x_padding = 0,
  },
}

require("fidget").setup(config)
-- TODO: use fidget to override `vim.notify`, remove nvim-notify
-- vim.notify = function(...)
--   return require("fidget.notification").notify(...)
-- end
