local sign = require("helper.sign").diagnostic

local spinners = {
  full = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" },
  small = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
  moon = { "🌑", "🌒", "🌓", "🌔", "🌕", "🌖", "🌗", "🌘" },
}

return {
  kind_labels = require("lsp.ui.completion").kind({ icon = "default" }),
  current_function = true,
  diagnostics = false,
  indicator_separator = " ",
  component_separator = " ",
  indicator_errors = sign.ERROR,
  indicator_warnings = sign.WARN,
  indicator_info = sign.INFO,
  indicator_hint = sign.HINT,
  indicator_ok = "",
  spinner_frames = spinners.moon,
  status_symbol = "",
  select_symbol = nil,
  update_interval = 100,
}
