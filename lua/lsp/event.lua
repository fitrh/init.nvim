local M = {}

local augroup = require("lib.event.augroup")

local function has(cmd)
  return vim.fn.exists(cmd) ~= 0
end

function M.attach()
  augroup.setup({
    ["HighlightOnCursor"] = {
      expect = has(":LspDocumentHighlight"),
      filter = "<buffer>",
      { events = "CursorHold", cmd = "LspDocumentHighlight" },
      { events = "CursorHoldI", cmd = "LspDocumentHighlight" },
      { events = "CursorMoved", cmd = "LspDocumentClearRefs" },
    },
    ["LineDiagnosticOnHold"] = {
      { events = "CursorHold", cmd = "DiagnosticShowInline" },
    },
    ["CodelensRefresh"] = {
      expect = has(":CodelensRefresh"),
      events = "BufEnter,BufLeave,InsertEnter,InsertLeave",
      filter = "<buffer>",
      { cmd = "CodelensRefresh" },
    },
  })
end

return M
