local M = {}

M.sign = {
  Error = "",
  Warning = "",
  Information = "",
  Hint = "",
}

M.with = function(args)
  local opts = args or {}
  local diagnostics = {
    Error = opts.e or M.sign.Error,
    Warning = opts.w or M.sign.Warning,
    Information = opts.i or M.sign.Information,
    Hint = opts.h or M.sign.Hint,
  }

  for type, text in pairs(diagnostics) do
    local diagnostic = ("LspDiagnosticsSign%s"):format(type)
    vim.fn.sign_define(
      diagnostic, {
        text = text,
        texthl = diagnostic,
      }
    )
  end
end

return M
