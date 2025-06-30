local LspKeymap = {}

function LspKeymap.attach(client, bufnr)
  local keymap = require("sugar.keymap")
  local map = keymap.map
  local leader, mode = keymap.modifier.leader, keymap.mode
  local n, v, i = mode.normal, mode.visual, mode.insert

  local lsp = vim.lsp.buf
  local ms = vim.lsp.protocol.Methods
  -- TODO: Consolidate with `:h lsp-defaults`
  local capabilities_map = {
    codeActionProvider = function()
      return {
        n(map("[a", lsp.code_action)),
        v(map("[a", lsp.code_action)),
      }
    end,
    codeLensProvider = n(map("gcl", vim.lsp.codelens.run)),
    renameProvider = n(map("cn", lsp.rename)),
    signatureHelpProvider = function() -- TODO: remove, use CTRL-S from `:h lsp-defaults`
      local ctrl_slash = [[]]
      return {
        n(map("[s", lsp.signature_help)),
        i(map(ctrl_slash, lsp.signature_help)),
      }
    end,
    declarationProvider = n(map("goD", lsp.declaration)),
    definitionProvider = n(map("god", lsp.definition)), -- TODO: remove, see `:h vim.lsp.tagfunc()
    typeDefinitionProvider = n(map("got", lsp.type_definition)),
    implementationProvider = n(map("gli", lsp.implementation)),
    referencesProvider = n(map("[r", lsp.references)),
    documentSymbolProvider = n(map("gls", lsp.document_symbol)), -- TODO: change to gO, also SEE: https://github.com/neovim/neovim/pull/30781
    workspaceSymbolProvider = n(map("glS", lsp.workspace_symbol)), -- TODO: remove, see `:h vim.lsp.tagfunc()
    callHierarchyProvider = function()
      return {
        n(map("gci", lsp.incoming_calls)),
        n(map("gco", lsp.outgoing_calls)),
      }
    end,
    [ms.textDocument_formatting] = n(map(leader("<CR>"), function()
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
    -- TODO: handle dynamic capability
    if
      client.server_capabilities[capability]
      or client.supports_method(capability)
    then
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
