local M = {}

function M.attach()
  local opts = '{ scope = "cursor", focusable = false, border = "rounded" }'

  local diagnostic = {
    SHOW = ("lua vim.diagnostic.open_float(0, %s)"):format(opts),
    NEXT = ("lua vim.diagnostic.goto_next({ float = %s })"):format(opts),
    PREV = ("lua vim.diagnostic.goto_prev({ float = %s })"):format(opts),
  }

  require("lib.command").group({
    prefix = "Diagnostic",
    option = "-buffer",
    create = {
      { name = "ShowInline", cmd = diagnostic.SHOW },
      { name = "GoToNext", cmd = diagnostic.NEXT },
      { name = "GoToPrev", cmd = diagnostic.PREV },
      { name = "LocList", cmd = "lua vim.diagnostic.setloclist()" },
    },
  })
end

return M
