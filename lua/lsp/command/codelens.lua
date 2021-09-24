local M = {}

function M.attach(client)
  if not client.resolved_capabilities.code_lens then
    return nil
  end

  require("lib.command").group({
    prefix = "Codelens",
    option = "-buffer",
    create = {
      { name = "Refresh", cmd = "lua vim.lsp.codelens.refresh()" },
      { name = "Run", cmd = "lua vim.lsp.codelens.run()" },
    },
  })
end

return M
