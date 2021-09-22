local M = {}

function M.attach(client, bufnr)
  local command = require("lib.command")
  local capable = client.resolved_capabilities

  if capable.document_formatting then
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

  if capable.signature_help then
    command.create({
      option = "-buffer",
      name = "LspSignatureHelp",
      cmd = "lua vim.lsp.buf.signature_help()",
    })
  end

  if capable.code_action then
    command.create({
      option = "-buffer",
      name = "LspCodeAction",
      cmd = "lua vim.lsp.buf.code_action()",
    })
  end

  if capable.hover then
    command.create({
      option = "-buffer",
      name = "LspHover",
      cmd = "lua vim.lsp.buf.hover()",
    })
  end

  if capable.declaration then
    command.create({
      option = "-buffer",
      name = "LspGoToDeclaration",
      cmd = "lua vim.lsp.buf.declaration()",
    })
  end

  if capable.goto_definition then
    command.create({
      option = "-buffer",
      name = "LspGoToDefinition",
      cmd = "lua vim.lsp.buf.definition()",
    })
  end

  if capable.type_definition then
    command.create({
      option = "-buffer",
      name = "LspGoToTypeDefinition",
      cmd = "lua vim.lsp.buf.type_definition()",
    })
  end

  if capable.implementation then
    command.create({
      option = "-buffer",
      name = "LspListImplementation",
      cmd = "lua vim.lsp.buf.implementation()",
    })
  end

  if capable.find_references then
    command.create({
      option = "-buffer",
      name = "LspListReferences",
      cmd = "lua vim.lsp.buf.references()",
    })
  end

  if capable.document_symbol then
    command.create({
      option = "-buffer",
      name = "LspListSymbols",
      cmd = "lua vim.lsp.buf.document_symbol()",
    })
  end

  if capable.call_hierarchy then
    command.group({
      prefix = "LspList",
      option = "-buffer",
      create = {
        { name = "Icoming", cmd = "lua vim.lsp.buf.incoming_calls()" },
        { name = "Outgoing", cmd = "lua vim.lsp.buf.outging_calls()" },
      },
    })
  end
end

return M
