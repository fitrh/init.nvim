local M = {}

function M.with(handlers)
  local _handlers = {}
  for _, handler in ipairs(handlers) do
    _handlers = vim.tbl_extend("keep", _handlers, handler)
  end
  return _handlers
end

function M.default()
  return M.with({ M.hover })
end

M.signature_help = {
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  }),
}

M.hover = {
  ["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = "rounded" }
  ),
}

return M
