local M = {}

M.on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  require("lsp_signature").on_attach(require("plugin.lspsignature.config"))
  require("lsp-status").on_attach(client)
  require("keymap.lsp").on_attach(client, bufnr)
  require("lsp.completion").with({ text = true, icon = "codicon" })
  require("lsp.diagnostic").with({ e = "", w = "", i = "", h = ""})
  require("lsp.event")
end

M.handlers = {
  ["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = false,
    }
  ),
  ["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help, {
      -- FIXME: html character (&nbsp) shown when use rounded border
      border = "single"
    }
  ),
  ["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, { border = "rounded" }
  ),
}

return M
