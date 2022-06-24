local M = {}

function M.attach(client, bufnr)
  local support = client.supports_method
  local lsp = vim.lsp
  local augroup = require("sugar.augroup")

  if support("textDocument/documentHighlight") then
    augroup({ "HighlightOnCursor", false }, function(autocmd)
      autocmd("CursorHold", bufnr, lsp.buf.document_highlight)
      autocmd(
        { "CursorMoved", "InsertEnter", "BufLeave" },
        bufnr,
        lsp.buf.clear_references
      )
    end)
  end

  if support("textDocument/formatting") then
    augroup({ "FormatOnSave", false }, function(autocmd)
      autocmd("BufWritePre", bufnr, function()
        local format_on_save = vim.b[bufnr].format_on_save
        if format_on_save then
          if type(format_on_save) ~= "table" then
            format_on_save = {}
          end

          lsp.buf.format({
            timeout_ms = format_on_save.timeout_ms or 1000,
            bufnr = bufnr,
          })
        end
      end)
    end)
  end

  if support("textDocument/codeLens") then
    augroup({ "CodelensRefresh", false }, function(autocmd)
      autocmd(
        { "BufEnter", "BufLeave", "InsertEnter", "InsertLeave" },
        bufnr,
        lsp.codelens.refresh
      )
    end)
  end
end

return M
