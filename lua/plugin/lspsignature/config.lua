local M = {
  bind = true,
  doc_lines = 0, -- 0 means disable API DOC in INSERT mode
  floating_window = true,
  hint_prefix = " () ",
  hint_scheme = "DiagnosticHint",
  hi_parameter = "LspSignatureActiveParameter",
  extra_trigger_chars = { "(", "{", "," },
  zindex = 200, -- 50 makes its floating windows below other floating windows
  tranparency = vim.api.nvim_get_option("pumblend"),
  toggle_key = "<M-x>",
}

return M
