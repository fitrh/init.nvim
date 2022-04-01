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
  if client.resolved_capabilities.code_lens then
    vim.lsp.codelens.refresh()
  end
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  command.buffer.attach(client, bufnr)
  command.codelens.attach(client, bufnr)
  command.diagnostic.attach(bufnr)
  keymap.lsp.attach(client, bufnr)
  keymap.diagnostic.attach(bufnr)
  event.attach(client, bufnr)
  diagnostic.attach()
end
