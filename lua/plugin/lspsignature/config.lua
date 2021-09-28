local M = {
  bind = true,
  floating_window = false,
  hint_prefix = " () ",
  hint_scheme = "LspDiagnosticsDefaultHint",
  hi_parameter = "LspSignatureActiveParameter",
  extra_trigger_chars = { "(", "{", "," },
  zindex = 200, -- by default it will be on top of all floating windows, set to 50 send it to bottom
}

return M
