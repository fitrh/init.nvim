local LspKeymap = {}

function LspKeymap.attach(client, bufnr)
  local capable = client.resolved_capabilities
  local lsp = vim.lsp.buf

  local keymap = require("sugar.keymap")
  local map = keymap.map
  local leader, n = keymap.modifier.leader, keymap.mode.normal

  local available_keymaps = {
    code_lens = n(map("gc", vim.lsp.codelens.run)),
    rename = n(map("[rn", lsp.rename)),
    signature_help = n(map("[s", lsp.signature_help)),
    hover = n(map("K", lsp.hover)),
    declaration = n(map("]D", lsp.declaration)),
    goto_definition = n(map("[D", lsp.definition)),
    type_definition = n(map("[T", lsp.type_definition)),
    implementation = n(map("]ll", lsp.implementation)),
    find_references = n(map("[ll", lsp.references)),
    document_symbol = n(map("]ls", lsp.document_symbol)),
    call_hierarchy = n(map("]li", lsp.incoming_calls)),
    call_Hierarchy = n(map("]lo", lsp.outgoing_calls)),
    document_formatting = n(map(leader("<CR>"), function()
      lsp.formatting_seq_sync({}, 5000)
      vim.schedule(function()
        vim.cmd("update")
      end)
    end)),
  }

  local keymaps = {}
  for capability, keydef in pairs(available_keymaps) do
    if capable[(capability):lower()] then
      table.insert(keymaps, keydef)
    end
  end

  keymap.bind(keymaps, { buffer = bufnr })
end

return LspKeymap
