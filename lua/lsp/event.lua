local M = {}

function M.attach(client, bufnr)
  local support = client.supports_method
  local event = require("sugar.event")
  local augroup, autocmd = event.augroup, event.autocmd

  if support("textDocument/documentHighlight") then
    local buf = vim.lsp.buf

    augroup({ "HighlightOnCursor", false }, {
      autocmd("CursorHold", bufnr, buf.document_highlight),
      autocmd(
        { "CursorMoved", "InsertEnter", "BufLeave" },
        bufnr,
        buf.clear_references
      ),
    })
  end

  if support("textDocument/codeLens") then
    augroup({ "CodelensRefresh", false }, {
      autocmd(
        { "BufEnter", "BufLeave", "InsertEnter", "InsertLeave" },
        bufnr,
        vim.lsp.codelens.refresh
      ),
    })
  end
end

return M
