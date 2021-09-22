local M = {}

function M.attach(client, bufnr)
  local command = require("lib.command")

  if client.resolved_capabilities.document_formatting then
    command.group({
      prefix = "LspFormat",
      option = "-buffer",
      create = {
        { name = "", cmd = "lua vim.lsp.buf.formatting()" },
        { name = "Seq", cmd = "lua vim.lsp.buf.formatting_seq_sync()" },
        { name = "Sync", cmd = "lua vim.lsp.buf.formatting_sync()" },
      },
    })
  end
end

return M
