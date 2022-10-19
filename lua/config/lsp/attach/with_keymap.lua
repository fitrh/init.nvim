local LspKeymap = {}

function LspKeymap.attach(client, bufnr)
  local keymap = require("sugar.keymap")
  local map = keymap.map
  local leader, mode = keymap.modifier.leader, keymap.mode
  local n, v = mode.normal, mode.vselect

  local lsp = vim.lsp.buf
  local capabilities_map = {
    codeActionProvider = function()
      return {
        n(map("[a", lsp.code_action)),
        v(map("[a", lsp.code_action)),
      }
    end,
    codeLensProvider = n(map("gcl", vim.lsp.codelens.run)),
    renameProvider = n(map("cn", lsp.rename)),
    signatureHelpProvider = n(map("[s", lsp.signature_help)),
    hoverProvider = n(map("K", lsp.hover)),
    declarationProvider = n(map("god", lsp.declaration)),
    definitionProvider = n(map("goD", lsp.definition)),
    typeDefinitionProvider = n(map("got", lsp.type_definition)),
    implementationProvider = n(map("gli", lsp.implementation)),
    referencesProvider = n(map("glr", lsp.references)),
    documentSymbolProvider = n(map("gls", lsp.document_symbol)),
    workspaceSymbolProvider = n(map("glS", lsp.workspace_symbol)),
    callHierarchyProvider = function()
      return {
        n(map("gci", lsp.incoming_calls)),
        n(map("gco", lsp.outgoing_calls)),
      }
    end,
    documentFormattingProvider = n(map(leader("<CR>"), function()
      lsp.format({ bufnr = bufnr, timeout_ms = 5000 })
      vim.schedule(function()
        vim.cmd.update()
      end)
    end)),
    documentRangeFormattingProvider = v(map(leader("<CR>"), function()
      lsp.format({ bufnr = bufnr, timeout_ms = 5000 })
    end)),
  }

  local keymaps = {}
  for capability, keydef in pairs(capabilities_map) do
    if client.server_capabilities[capability] then
      if type(keydef) == "function" then
        for _, def in ipairs(keydef()) do
          table.insert(keymaps, def)
        end
      else
        table.insert(keymaps, keydef)
      end
    end
  end

  keymap.bind(keymaps, { buffer = bufnr })
end

return LspKeymap
