local M = {
  bind = true,
  floating_window = false,
  hint_prefix = " () ",
  hint_scheme = "DiagnosticHint",
  hi_parameter = "LspSignatureActiveParameter",
  max_height = 10,
  max_width = 80,
  extra_trigger_chars = { "(", "{", "," },
  zindex = 50, -- by default it will be on top of all floating windows, set to 50 send it to bottom
  tranparency = vim.api.nvim_get_option("pumblend"),
  toggle_key = "<M-x>",
}

return M
