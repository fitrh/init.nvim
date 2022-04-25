local LspKeymap = {}

function LspKeymap.attach(client, bufnr)
  local capable = client.resolved_capabilities
  local lsp = vim.lsp.buf

  local keymap = require("sugar.keymap")
  local map = keymap.map
  local leader, mode = keymap.modifier.leader, keymap.mode
  local n, v = mode.normal, mode.vselect

  local available_keymaps = {
    code_action = function()
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
    code_lens = n(map("gcl", vim.lsp.codelens.run)),
    rename = n(map("grn", lsp.rename)),
    signature_help = n(map("[s", lsp.signature_help)),
    hover = n(map("K", lsp.hover)),
    declaration = n(map("god", lsp.declaration)),
    goto_definition = n(map("goD", lsp.definition)),
    type_definition = n(map("got", lsp.type_definition)),
    implementation = n(map("gli", lsp.implementation)),
    find_references = n(map("glr", lsp.references)),
    document_symbol = n(map("gls", lsp.document_symbol)),
    workspace_symbol = n(map("glS", lsp.workspace_symbol)),
    call_hierarchy = function()
      return {
        n(map("gci", lsp.incoming_calls)),
        n(map("gco", lsp.outgoing_calls)),
      }
    end,
    document_formatting = n(map(leader("<CR>"), function()
      lsp.formatting_seq_sync(nil, 5000)
      vim.schedule(function()
        vim.cmd("update")
      end)
    end)),
    document_range_formatting = v(map(leader("<CR>"), lsp.range_formatting)),
  }

  local keymaps = {}
  for capability, keydef in pairs(available_keymaps) do
    if capable[capability] then
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
