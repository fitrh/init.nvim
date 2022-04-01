local M = {}

local function opts(scope)
  return { scope = scope, focusable = false, border = "rounded" }
end

local scope = { cursor = "cursor", line = "line" }

function M.attach(bufnr)
  local api = vim.diagnostic

  require("sugar.command").group({
    prefix = "Diagnostic",
    buf = bufnr,
    cmds = {
      {
        name = "ShowInLine",
        cmd = function()
          api.open_float(0, opts(scope.line))
        end,
      },
      {
        name = "ShowOnCursor",
        cmd = function()
          api.open_float(0, opts(scope.cursor))
        end,
      },
      {
        name = "GoToNext",
        cmd = function()
          api.goto_next({ float = opts(scope.cursor) })
        end,
      },
      {
        name = "GoToPrev",
        cmd = function()
          api.goto_prev({ float = opts(scope.cursor) })
        end,
      },
      { name = "LocList", cmd = api.setloclist },
    },
  })
end

return M
