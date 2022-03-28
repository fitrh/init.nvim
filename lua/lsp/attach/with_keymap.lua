local LspKeymap = {}

function LspKeymap.attach(client, bufnr)
  local capable = client.resolved_capabilities
  local lsp = vim.lsp.buf

  local keymap = require("sugar.keymap")
  local bind, map = keymap.bind, keymap.map
  local leader, n = keymap.modifier.leader, keymap.mode.normal

  if capable.code_lens then
    bind(n(map("gc", vim.lsp.codelens.run, { buffer = bufnr })))
  end

  if capable.document_formatting then
    bind(n(map(leader("<CR>"), function()
      lsp.formatting_seq_sync({}, 5000)
      vim.cmd("update")
    end, { buffer = bufnr })))
  end

  if capable.rename then
    bind(n(map("[rn", lsp.rename, { buffer = bufnr })))
  end

  if capable.signature_help then
    bind(n(map("[s", lsp.signature_help, { buffer = bufnr })))
  end

  if capable.hover then
    bind(n(map("K", lsp.hover, { buffer = bufnr })))
  end

  if capable.declaration then
    bind(n(map("]D", lsp.declaration, { buffer = bufnr })))
  end

  if capable.goto_definition then
    bind(n(map("[D", lsp.definition, { buffer = bufnr })))
  end

  if capable.type_definition then
    bind(n(map("[T", lsp.type_definition, { buffer = bufnr })))
  end

  if capable.implementation then
    bind(n(map("]ll", lsp.implementation, { buffer = bufnr })))
  end

  if capable.find_references then
    bind(n(map("[ll", lsp.references, { buffer = bufnr })))
  end

  if capable.document_symbol then
    bind(n(map("]ls", lsp.document_symbol, { buffer = bufnr })))
  end

  if capable.call_hierarchy then
    bind({
      n(map("]li", function()
        lsp.incoming_calls()
      end)),
      n(map("]lo", function()
        lsp.outgoing_calls()
      end)),
    }, { buffer = bufnr })
  end
end

return LspKeymap
