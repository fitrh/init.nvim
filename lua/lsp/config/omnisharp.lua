return {
  cmd = {
    ("%s/omnisharp/run"):format(os.getenv("DOTNET_ROOT")),
    "--languageserver",
    "--hostPID",
    tostring(vim.fn.getpid()),
  },
  capabilities = require("lsp.capability"),
  handlers = require("lsp.handler").default(),
  on_attach = require("lsp.attach").with_all_extensions,
}
