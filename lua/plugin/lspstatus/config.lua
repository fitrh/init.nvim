local sign = require("lsp.ui.diagnostic").sign

local spinners = {
  full = {"⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷"},
  small = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
}

return {
  kind_labels = require("lsp.ui.completion").kind({ icon = "default" }),
  current_function = true,
  diagnostics = false,
  indicator_separator = " ",
  component_separator = " ",
  indicator_errors = sign.Error,
  indicator_warnings = sign.Warning,
  indicator_info = sign.Information,
  indicator_hint = sign.Hint,
  indicator_ok = "",
  spinner_frames = spinners.small,
  status_symbol = "",
  select_symbol = nil,
  update_interval = 100
}
