local command = require("lib.command")

local M = {}

function M.attach(client, bufnr)
  if client.resolved_capabilities.document_formatting then
    command.create({
      option = "-buffer",
      name = "LspFormat",
      cmd = "lua vim.lsp.buf.formatting()",
    })
  end
end

return M
