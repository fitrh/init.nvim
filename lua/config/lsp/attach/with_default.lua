return function(client, bufnr)
  require("config.lsp.command.buffer").attach(client, bufnr)
  require("config.lsp.command.diagnostic").attach(bufnr)

  if client.server_capabilities.codeLensProvider then
    vim.lsp.codelens.refresh()
    require("config.lsp.command.codelens").attach(bufnr)
  end

  require("config.lsp.attach.with_keymap").attach(client, bufnr)
  require("config.lsp.attach.with_diagnostic_keymap").attach(bufnr)
  require("config.lsp.event").attach(client, bufnr)
  require("config.lsp.diagnostic").attach()
  vim.api.nvim_buf_set_var(bufnr, "lsp_attached", true)
end
