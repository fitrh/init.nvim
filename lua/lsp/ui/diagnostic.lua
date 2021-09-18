local M = {}

function M.attach(args)
  local sign = require("helper.sign").diagnostic
  local opts = args or {}
  local diagnostics = {
    Error = opts.e or sign.ERROR,
    Warn = opts.w or sign.WARN,
    Info = opts.i or sign.INFO,
    Hint = opts.h or sign.HINT,
  }

  for type, text in pairs(diagnostics) do
    local diagnostic = ("DiagnosticSign%s"):format(type)
    vim.fn.sign_define(diagnostic, {
      text = text,
      texthl = diagnostic,
      numhl = diagnostic,
    })
  end

  vim.diagnostic.config({
    virtual_text = false,
  })
end

return M
