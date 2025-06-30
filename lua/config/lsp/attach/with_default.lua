---@param client vim.lsp.Client
---@param bufnr number
return function(client, bufnr)
  require("config.lsp.command.buffer").attach(client, bufnr)
  require("config.lsp.command.diagnostic").attach(bufnr)

  local lsp = vim.lsp
  local m = lsp.protocol.Methods

  -- if client.supports_method(m.textDocument_completion, { bufnr = bufnr }) then
  --   lsp.completion.enable(true, client.id, bufnr, {
  --     autotrigger = true,
  --   })
  -- end

  if client.server_capabilities.codeLensProvider then
    lsp.codelens.refresh({ bufnr = bufnr })
    require("config.lsp.command.codelens").attach(bufnr)
  end

  require("config.lsp.attach.with_keymap").attach(client, bufnr)
  require("config.lsp.event").attach(client, bufnr)
  require("config.lsp.diagnostic").attach(bufnr)

  vim.api.nvim_buf_set_var(bufnr, "lsp_attached", true)
end
