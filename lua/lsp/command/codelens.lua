local M = {}

function M.attach(client, bufnr)
  if not client.resolved_capabilities.code_lens then
    return nil
  end

  require("sugar.command").group({
    prefix = "Codelens",
    buf = bufnr,
    cmds = {
      { name = "Refresh", cmd = vim.lsp.codelens.refresh },
      { name = "Run", cmd = vim.lsp.codelens.run },
    },
  })
end

return M
