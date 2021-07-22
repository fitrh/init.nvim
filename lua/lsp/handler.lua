local M = {}

function M.with(handlers)
  local _handlers = {}
  for _,handler in ipairs(handlers) do
    _handlers = vim.tbl_extend("error", _handlers, handler)
  end
  return _handlers
end

function M.default()
  return M.with({ M.on_publish_diagnostics, M.hover })
end

M.on_publish_diagnostics = {
  ["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = false,
    }
  ),
}

M.signature_help = {
  ["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help, {
      border = "rounded"
    }
  ),
}

M.hover = {
  ["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, { border = "rounded" }
  ),
}

return M
