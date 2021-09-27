local M = {}

local augroup = require("lib.event.augroup")

local function has(cmd)
  return vim.fn.exists(cmd) ~= 0
end

function M.attach(client)
  local capable = client.resolved_capabilities
  augroup.setup({
    ["HighlightOnCursor"] = {
      expect = capable.document_highlight and has(":LspDocumentHighlight"),
      filter = "<buffer>",
      { events = "CursorHold", cmd = "LspDocumentHighlight" },
      { events = "CursorMoved", cmd = "LspDocumentClearRefs" },
      { events = "InsertEnter", cmd = "LspDocumentClearRefs" },
    },
    ["LineDiagnosticOnHold"] = {
      { events = "CursorHold", cmd = "DiagnosticShowInline" },
    },
    ["CodelensRefresh"] = {
      expect = capable.code_lens and has(":CodelensRefresh"),
      events = "BufEnter,BufLeave,InsertEnter,InsertLeave",
      filter = "<buffer>",
      { cmd = "CodelensRefresh" },
    },
  })
end

return M
