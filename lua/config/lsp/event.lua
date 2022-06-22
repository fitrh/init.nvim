local M = {}

function M.attach(client, bufnr)
  local support = client.supports_method
  local augroup = require("sugar.augroup")

  if support("textDocument/documentHighlight") then
    local buf = vim.lsp.buf
    augroup({ "HighlightOnCursor", false }, function(autocmd)
      autocmd("CursorHold", bufnr, buf.document_highlight)
      autocmd(
        { "CursorMoved", "InsertEnter", "BufLeave" },
        bufnr,
        buf.clear_references
      )
    end)
  end

  if support("textDocument/codeLens") then
    augroup({ "CodelensRefresh", false }, function(autocmd)
      autocmd(
        { "BufEnter", "BufLeave", "InsertEnter", "InsertLeave" },
        bufnr,
        vim.lsp.codelens.refresh
      )
    end)
  end
end

return M
