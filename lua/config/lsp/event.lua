local M = {}

function M.attach(client, bufnr)
  local capable = client.server_capabilities
  local lsp = vim.lsp
  local augroup = require("sugar.augroup")

  if capable.documentHighlightProvider then
    augroup({ "highlight_references", false }, function(autocmd)
      autocmd("CursorHold", bufnr, lsp.buf.document_highlight)
      local event = { "CursorMoved", "InsertEnter", "BufLeave" }
      autocmd(event, bufnr, lsp.buf.clear_references)
    end)
  end

  if capable.documentFormattingProvider then
    augroup({ "format_on_save", false }, function(autocmd)
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

  if capable.codeLensProvider then
    augroup({ "codelens_refresh", false }, function(autocmd)
      local event = { "BufEnter", "BufLeave", "InsertEnter", "InsertLeave" }
      autocmd(event, bufnr, lsp.codelens.refresh)
    end)
  end
end

return M
