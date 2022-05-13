return function(client, bufnr)
  require("lsp.command.buffer").attach(client, bufnr)
  require("lsp.command.diagnostic").attach(bufnr)

  if client.supports_method("textDocument/codeLens") then
    vim.lsp.codelens.refresh()
    require("lsp.command.codelens").attach(bufnr)
  end

  require("lsp.attach.with_keymap").attach(client, bufnr)
  require("lsp.attach.with_diagnostic_keymap").attach(bufnr)
  require("lsp.event").attach(client, bufnr)
  require("lsp.diagnostic").attach()
end
