require("util.event.augroup").setup({
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

