local keymap = require("keymap.lsp")
local event = require("lsp.event")
local command = {
  buffer = require("lsp.command.buffer"),
  codelens = require("lsp.command.codelens"),
  diagnostic = require("lsp.command.diagnostic"),
}
local ui = { diagnostic = require("lsp.ui.diagnostic") }

return function(client, bufnr)
  if client.resolved_capabilities.code_lens then
    vim.lsp.codelens.refresh()
  end
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  command.buffer.attach(client)
  command.codelens.attach(client)
  command.diagnostic.attach()
  keymap.attach(bufnr)
  event.attach(client)
  ui.diagnostic.attach()
end
