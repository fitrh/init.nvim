local M = {
  bind = true,
  doc_lines = 0, -- 0 means disable API DOC in INSERT mode
  floating_window = true,
  hint_enable = false,
  hint_prefix = " () ",
  hint_scheme = "DiagnosticHint",
  extra_trigger_chars = { "(", "{", "," },
  padding = " ",
  transparency = vim.api.nvim_get_option("pumblend"),
  toggle_key = "<M-x>",
  select_signature_key = "<C-n>",
}

return M
