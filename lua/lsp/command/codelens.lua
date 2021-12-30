local M = {}

function M.attach(client)
  if not client.resolved_capabilities.code_lens then
    return nil
  end

  require("lib.command").group({
    prefix = "Codelens",
    buf = true,
    cmds = {
      { name = "Refresh", cmd = vim.lsp.codelens.refresh },
      { name = "Run", cmd = vim.lsp.codelens.run },
    },
  })
end

return M
