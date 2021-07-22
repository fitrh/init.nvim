local M = {}

local augroup = require("util.event.augroup")

function M.highlight_on_cursor_hold()
  augroup.setup({
    ["HighlightOnCursor"] = {
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
  })
end

return M
