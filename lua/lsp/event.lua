local M = {}

local augroup = require("sugar.augroup")

function M.attach(client, bufnr)
  local capable_of = client.resolved_capabilities

  if capable_of.document_highlight then
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

  if capable_of.code_lens then
    augroup("CodelensRefresh", {
      { "BufEnter", "BufLeave", "InsertEnter", "InsertLeave" },
      callback = vim.lsp.codelens.refresh,
      buffer = bufnr,
    })
  end
end

return M
