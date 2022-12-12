local function trim(str)
  str = str:gsub("^%s*(.-)%s*$", "%1")

  if string.sub(str, -1, -1) == "." then
    str = string.sub(str, 1, -2)
    str = str:gsub("^%s*(.-)%s*$", "%1")
  end

  return str
end

local M = {}

function M.attach(bufnr)
  local sign = require("const.DIAGNOSTIC_SIGN")
  local severities = {
    [vim.diagnostic.severity.ERROR] = { text = "Error", sign = sign.ERROR },
    [vim.diagnostic.severity.WARN] = { text = "Warn", sign = sign.WARN },
    [vim.diagnostic.severity.INFO] = { text = "Info", sign = sign.INFO },
    [vim.diagnostic.severity.HINT] = { text = "Hint", sign = sign.HINT },
  }

  for _, severity in pairs(severities) do
    local hl = ("DiagnosticSign%s"):format(severity.text)
    vim.fn.sign_define(hl, { text = severity.sign, texthl = hl, numhl = hl })
  end

  vim.diagnostic.config({
    virtual_text = false,
    float = {
      format = function(diagnostic)
        return trim(diagnostic.message)
      end,
      prefix = function(diagnostic, i, total)
        local hl = "Comment"
        local prefix = total > 1 and ("%d. "):format(i) or ""

        if diagnostic.source then
          prefix = ("%s%s: "):format(prefix, trim(diagnostic.source))
        end

        return prefix, hl
      end,
    },
    severity_sort = true,
  })

  require("config.lsp.attach.with_diagnostic_keymap").attach(bufnr)

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
