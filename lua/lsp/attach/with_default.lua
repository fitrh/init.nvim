local event = require("lsp.event")
local command = {
  buffer = require("lsp.command.buffer"),
  codelens = require("lsp.command.codelens"),
  diagnostic = require("lsp.command.diagnostic"),
}
local keymap = {
  lsp = require("lsp.attach.with_keymap"),
  diagnostic = require("lsp.attach.with_diagnostic_keymap"),
}
local diagnostic = require("lsp.diagnostic")

return function(client, bufnr)
  if client.supports_method("textDocument/codeLens") then
    vim.lsp.codelens.refresh()
  end
  command.buffer.attach(client, bufnr)
  command.codelens.attach(client, bufnr)
  command.diagnostic.attach(bufnr)
  keymap.lsp.attach(client, bufnr)
  keymap.diagnostic.attach(bufnr)
  event.attach(client, bufnr)
  diagnostic.attach()
end
