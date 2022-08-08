local LspKeymap = {}

function LspKeymap.attach(client, bufnr)
  local keymap = require("sugar.keymap")
  local map = keymap.map
  local leader, mode = keymap.modifier.leader, keymap.mode
  local n, v = mode.normal, mode.vselect

  local lsp = vim.lsp.buf
  local available_keymaps = {
    ["textDocument/codeAction"] = function()
      return {
        n(map("[a", lsp.code_action)),
        v(map("[a", function()
          lsp.range_code_action(
            nil,
            { vim.fn.line("v"), -1 },
            { vim.fn.line("."), -1 }
          )
        end)),
      }
    end,
    ["textDocument/codeLens"] = n(map("gcl", vim.lsp.codelens.run)),
    ["textDocument/rename"] = n(map("grn", lsp.rename)),
    ["textDocument/signatureHelp"] = n(map("[s", lsp.signature_help)),
    ["textDocument/hover"] = n(map("K", lsp.hover)),
    ["textDocument/declaration"] = n(map("god", lsp.declaration)),
    ["textDocument/definition"] = n(map("goD", lsp.definition)),
    ["textDocument/typeDefinition"] = n(map("got", lsp.type_definition)),
    ["textDocument/implementation"] = n(map("gli", lsp.implementation)),
    ["textDocument/references"] = n(map("glr", lsp.references)),
    ["textDocument/documentSymbol"] = n(map("gls", lsp.document_symbol)),
    ["workspace/symbol"] = n(map("glS", lsp.workspace_symbol)),
    ["textDocument/prepareCallHierarchy"] = function()
      return {
        n(map("gci", lsp.incoming_calls)),
        n(map("gco", lsp.outgoing_calls)),
      }
    end,
    ["textDocument/formatting"] = n(map(leader("<CR>"), function()
      lsp.format({ bufnr = bufnr, timeout_ms = 5000 })
      vim.schedule(function()
        vim.cmd.update()
      end)
    end)),
    ["textDocument/rangeFormatting"] = v(
      map(leader("<CR>"), lsp.range_formatting)
    ),
  }

  local support = client.supports_method
  local keymaps = {}
  for request, keydef in pairs(available_keymaps) do
    if support(request) then
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
