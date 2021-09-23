local M = {}

function M.attach()
  require("lib.command").group({
    prefix = "Diagnostic",
    option = "-buffer",
    create = {
      {
        name = "ShowInline",
        cmd = "lua vim.diagnostic.show_line_diagnostics({ focusable = false, border = 'rounded', source = 'always'})",
      },
      {
        name = "GoToNext",
        cmd = "lua vim.diagnostic.goto_next({ popup_opts = { focusable = false, border = 'rounded', source = 'always' } })",
      },
      {
        name = "GoToPrev",
        cmd = "lua vim.diagnostic.goto_prev({ popup_opts = { focusable = false, border = 'rounded', source = 'always' } })",
      },
      {
        name = "LocList",
        cmd = "lua vim.diagnostic.setloclist()",
      },
    },
  })
end

return M
