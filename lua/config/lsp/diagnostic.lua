local function with_diagnostic_code(result)
  local msg = result.message
  local ends_w_dot = string.sub(msg, -1, -1) == "."

  if ends_w_dot then
    msg = string.sub(msg, 1, -2)
  end

  if result.code then
    return ("%s [%s]"):format(msg, result.code)
  end

  return msg
end

local M = {}

function M.attach(args)
  local sign = require("const.DIAGNOSTIC_SIGN")
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
    float = {
      source = "always",
      format = with_diagnostic_code,
    },
    severity_sort = true,
  })

  require("sugar.augroup")("diagnostic_on_insert", function(autocmd)
    autocmd("InsertEnter", "*", function(args)
      vim.diagnostic.hide(nil, args.buf)
    end)

    autocmd("InsertLeave", "*", function(args)
      vim.diagnostic.show(nil, args.buf)
    end)
  end)
end

return M
