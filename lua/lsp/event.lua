local M = {}

local augroup = require("lib.event.augroup")

function M.attach(client)
  augroup.setup({
    ["FormatOnWrite"] = {
      expect = client.resolved_capabilities.document_formatting,
      filter = "<buffer>",
      events = "BufWritePre",
      { cmd = "lua vim.lsp.buf.formatting_sync()" },
    },
    ["HighlightOnCursor"] = {
      expect = client.resolved_capabilities.document_highlight,
      filter = "<buffer>",
      {
        events = "CursorHold",
        cmd = "lua vim.lsp.buf.document_highlight()"
      },
      {
        events = "CursorHoldI",
        cmd = "lua vim.lsp.buf.document_highlight()"
      },
      {
        events = "CursorMoved",
        cmd = "lua vim.lsp.buf.clear_references()"
      },
    },
    ["LineDiagnosticOnHold"] = {
      events = "CursorHold",
      { cmd = "lua vim.lsp.diagnostic.show_line_diagnostics({ focusable = false, border = 'rounded' })", },
    },
    ["CodelensRefresh"] = {
      expect = client.resolved_capabilities.code_lens,
      events = "BufEnter,BufLeave,InsertEnter,InsertLeave",
      filter = "<buffer>",
      { cmd = "lua vim.lsp.codelens.refresh()" }
    },
  })
end

return M
