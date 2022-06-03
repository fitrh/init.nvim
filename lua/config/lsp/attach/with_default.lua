return function(client, bufnr)
  require("config.lsp.command.buffer").attach(client, bufnr)
  require("config.lsp.command.diagnostic").attach(bufnr)

  if client.supports_method("textDocument/codeLens") then
    vim.lsp.codelens.refresh()
    require("config.lsp.command.codelens").attach(bufnr)
  end

  require("config.lsp.attach.with_keymap").attach(client, bufnr)
  require("config.lsp.attach.with_diagnostic_keymap").attach(bufnr)
  require("config.lsp.event").attach(client, bufnr)
  require("config.lsp.diagnostic").attach()
end
