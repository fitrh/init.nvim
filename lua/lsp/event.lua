local M = {}

local augroup = require("sugar.augroup")

function M.attach(client, bufnr)
  local support = client.supports_method

  if support("textDocument/documentHighlight") then
    local buf = vim.lsp.buf

    augroup("HighlightOnCursor", {
      { "CursorHold", callback = buf.document_highlight, buffer = bufnr },
      {
        { "CursorMoved", "InsertEnter", "BufLeave" },
        callback = buf.clear_references,
        buffer = bufnr,
      },
    })
  end

  if support("textDocument/codeLens") then
    augroup("CodelensRefresh", {
      { "BufEnter", "BufLeave", "InsertEnter", "InsertLeave" },
      callback = vim.lsp.codelens.refresh,
      buffer = bufnr,
    })
  end
end

return M
