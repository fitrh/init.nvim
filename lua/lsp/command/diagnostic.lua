local M = {}

function M.attach()
  local opts = '{ focusable = false, border = "rounded", source = "always" }'
  local diagnostic = {
    SHOW = ("lua vim.diagnostic.show_line_diagnostics(%s)"):format(opts),
    NEXT = ("lua vim.diagnostic.goto_next({ popup_opts = %s })"):format(opts),
    PREV = ("lua vim.diagnostic.goto_prev({ popup_opts = %s })"):format(opts),
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
