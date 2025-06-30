local M = vim.lsp.protocol.make_client_capabilities()

M.window = M.window or {}
M.window.workDoneProgress = true

-- SEE: https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#completionClientCapabilities
M.textDocument.completion.completionItem.snippetSupport = true
M.textDocument.completion.completionItem.documentationFormat = {
  "markdown",
  "plaintext",
}
M.textDocument.completion.completionItem.commitCharactersSupport = true
M.textDocument.completion.completionItem.deprecatedSupport = true
M.textDocument.completion.completionItem.preselectSupport = true
M.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
M.textDocument.completion.completionItem.insertReplaceSupport = true
M.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
    "sortText",
    "filterText",
    "insertText",
    "textEdit",
    "insertTextFormat",
    "insertTextMode",
  },
}
M.textDocument.completion.completionItem.insertTextModeSupport = {
  valueSet = { 1, 2 },
}
M.textDocument.completion.completionItem.labelDetailsSupport = true

M.textDocument.completion.contextSupport = true
M.textDocument.completion.insertTextMode = 1
M.textDocument.completion.completionList = {
  itemDefaults = {
    "commitCharacters",
    "editRange",
    "insertTextFormat",
    "insertTextMode",
    "data",
  },
}

return M
