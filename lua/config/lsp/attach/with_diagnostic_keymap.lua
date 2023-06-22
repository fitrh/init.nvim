local DiagnosticKeymap = {}

function DiagnosticKeymap.attach(bufnr)
  local function opts(scope)
    return {
      buffer = bufnr,
      scope = scope,
      focusable = false,
      border = "solid",
    }
  end
  local scope = { cursor = "cursor", line = "line" }
  local api = vim.diagnostic

  local keymap = require("sugar.keymap")
  local map, leader, n = keymap.map, keymap.modifier.leader, keymap.mode.normal

  local keymaps = {
    n(map(leader("d"), function()
      api.open_float(opts(scope.cursor))
    end)),

    n(map(leader("D"), function()
      api.open_float(opts(scope.line))
    end)),

    n(map("]d", function()
      api.goto_next({ float = opts(scope.cursor) })
    end)),

    n(map("[d", function()
      api.goto_prev({ float = opts(scope.cursor) })
    end)),

    n(map(leader("ll"), api.setloclist)),
    n(map(leader("lL"), api.setqflist)),
  }

  keymap.bind(keymaps, { buffer = true })
end

return DiagnosticKeymap
