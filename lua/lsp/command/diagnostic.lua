local M = {}

function M.attach()
  local default = 'focusable = false, border = "rounded"'
  local opts = {
    cursor = 'scope = "cursor", ' .. default,
    line = 'scope = "line", ' .. default,
  }

  local api = "lua vim.diagnostic"
  local diagnostic = {
    SHOW = {
      cursor = ("%s.open_float(0, { %s })"):format(api, opts.cursor),
      line = ("%s.open_float(0, { %s })"):format(api, opts.line),
    },
    NEXT = ("%s.goto_next({ float = { %s } })"):format(api, opts.cursor),
    PREV = ("%s.goto_prev({ float = { %s } })"):format(api, opts.cursor),
  }

  require("lib.command").group({
    prefix = "Diagnostic",
    buf = true,
    cmds = {
      { name = "ShowInLine", cmd = diagnostic.SHOW.line },
      { name = "ShowOnCursor", cmd = diagnostic.SHOW.cursor },
      { name = "GoToNext", cmd = diagnostic.NEXT },
      { name = "GoToPrev", cmd = diagnostic.PREV },
      { name = "LocList", cmd = vim.diagnostic.setloclist },
    },
  })
end

return M
