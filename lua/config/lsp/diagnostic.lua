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
  vim.diagnostic.config({
    virtual_text = false,
    signs = false,
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
      if not vim.diagnostic.is_disabled(args.buf) then
        vim.diagnostic.hide(nil, args.buf)
      end
    end)

    autocmd("InsertLeave", "*", function(args)
      if not vim.diagnostic.is_disabled(args.buf) then
        vim.diagnostic.show(nil, args.buf)
      end
    end)
  end)
end

return M
