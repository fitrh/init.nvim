local M = {}

function M.attach(client, bufnr)
  if not client.supports_method("textDocument/codeLens") then
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
