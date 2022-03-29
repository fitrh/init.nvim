local M = {}

function M.attach(client)
  local capable = client.resolved_capabilities
  local command = require("lib.command")
  local lsp = vim.lsp.buf

  if capable.document_formatting then
    local default = 5000

    command.group({
      prefix = "LspFormat",
      opts = { nargs = "?" },
      buf = true,
      cmds = {
        { cmd = lsp.formatting },
        {
          name = "Seq",
          cmd = function(opts)
            lsp.formatting_seq_sync({}, tonumber(opts.fargs[1]) or default)
          end,
        },
        {
          name = "Sync",
          cmd = function(opts)
            lsp.formatting_sync({}, tonumber(opts.fargs[1]) or default)
          end,
        },
      },
    })
  end

  if capable.rename then
    command.add("LspRename", function()
      lsp.rename()
    end, { buf = true })
  end

  if capable.signature_help then
    command.add("LspSignatureHelp", lsp.signature_help, { buf = true })
  end

  if capable.code_action then
    command.add("LspCodeAction", lsp.code_action, { buf = true })
  end

  if capable.hover then
    command.add("LspHover", lsp.hover, { buf = true })
  end

  if capable.declaration then
    command.add("LspGoToDeclaration", lsp.declaration, { buf = true })
  end

  if capable.goto_definition then
    command.add("LspGoToDefinition", lsp.definition, { buf = true })
  end

  if capable.type_definition then
    command.add("LspGoToTypeDefinition", lsp.type_definition, { buf = true })
  end

  if capable.implementation then
    command.add("LspListImplementation", lsp.implementation, { buf = true })
  end

  if capable.find_references then
    command.add("LspListReferences", lsp.references, { buf = true })
  end

  if capable.document_symbol then
    command.add("LspListSymbols", lsp.document_symbol, { buf = true })
  end

  if capable.document_highlight then
    command.group({
      prefix = "LspDocument",
      buf = true,
      cmds = {
        { name = "Highlight", cmd = lsp.document_highlight },
        { name = "ClearRefs", cmd = lsp.clear_references },
      },
    })
  end

  if capable.call_hierarchy then
    command.group({
      prefix = "LspList",
      buf = true,
      cmds = {
        {
          name = "Icoming",
          cmd = function()
            lsp.incoming_calls()
          end,
        },
        {
          name = "Outgoing",
          cmd = function()
            lsp.outgoing_calls()
          end,
        },
      },
    })
  end
end

return M
