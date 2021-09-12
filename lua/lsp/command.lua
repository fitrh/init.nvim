local command = require("lib.command")

local M = {}

function M.attach(client, bufnr)
  if client.resolved_capabilities.document_formatting then
    command.create({
      option = "-buffer",
      name = "LspFormat",
      cmd = "lua vim.lsp.buf.formatting()",
    })
    command.create({
      option = "-buffer",
      name = "LspFormatSeq",
      cmd = "lua vim.lsp.buf.formatting_seq_sync()",
    })
    command.create({
      option = "-buffer",
      name = "LspFormatSync",
      cmd = "lua vim.lsp.buf.formatting_sync()",
    })
  end
end

return M
