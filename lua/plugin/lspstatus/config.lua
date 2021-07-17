local sign = require("lsp.diagnostic").sign

return {
  kind_labels = require("lsp.completion").kind({ icon = "codicon" }),
  current_function = true,
  diagnostics = false,
  indicator_separator = " ",
  component_separator = " ",
  indicator_errors = sign.Error,
  indicator_warnings = sign.Warning,
  indicator_info = sign.Information,
  indicator_hint = sign.Hint,
  indicator_ok = "",
  spinner_frames = {"⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷"},
  status_symbol = "",
  select_symbol = nil,
  update_interval = 100
}
