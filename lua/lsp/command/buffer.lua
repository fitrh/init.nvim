local M = {}

function M.attach(client, bufnr)
  local capable = client.resolved_capabilities
  local command = require("sugar.command")
  local lsp = vim.lsp.buf

  if capable.document_formatting then
    local default = 5000

    command.group({
      prefix = "LspFormat",
      opts = { nargs = "?" },
      buf = bufnr,
      cmds = {
        { cmd = lsp.formatting },
        {
          name = "Seq",
          cmd = function(opts)
            lsp.formatting_seq_sync(nil, tonumber(opts.fargs[1]) or default)
          end,
        },
        {
          name = "Sync",
          cmd = function(opts)
            lsp.formatting_sync(nil, tonumber(opts.fargs[1]) or default)
          end,
        },
      },
    })
  end

  if capable.document_range_formatting then
    command.add(
      "LspFormatRange",
      lsp.range_formatting,
      { buf = bufnr, opts = { range = true } }
    )
  end

  if capable.rename then
    command.add("LspRename", function()
      lsp.rename()
    end, { buf = bufnr })
  end

  if capable.signature_help then
    command.add("LspSignatureHelp", lsp.signature_help, { buf = bufnr })
  end

  if capable.code_action then
    command.add("LspCodeAction", lsp.code_action, { buf = bufnr })
  end

  if capable.hover then
    command.add("LspHover", lsp.hover, { buf = bufnr })
  end

  if capable.declaration then
    command.add("LspGoToDeclaration", lsp.declaration, { buf = bufnr })
  end

  if capable.goto_definition then
    command.add("LspGoToDefinition", lsp.definition, { buf = bufnr })
  end

  if capable.type_definition then
    command.add("LspGoToTypeDefinition", lsp.type_definition, { buf = bufnr })
  end

  if capable.implementation then
    command.add("LspListImplementation", lsp.implementation, { buf = bufnr })
  end

  if capable.find_references then
    command.add("LspListReferences", lsp.references, { buf = bufnr })
  end

  if capable.document_symbol then
    command.add("LspListSymbols", lsp.document_symbol, { buf = bufnr })
  end

  if capable.workspace_symbol then
    command.add(
      "LspListWorkspaceSymbols",
      lsp.workspace_symbol,
      { buf = bufnr }
    )
  end

  if capable.document_highlight then
    command.group({
      prefix = "LspDocument",
      buf = bufnr,
      cmds = {
        { name = "Highlight", cmd = lsp.document_highlight },
        { name = "ClearRefs", cmd = lsp.clear_references },
      },
    })
  end

  if capable.call_hierarchy then
    command.group({
      prefix = "LspList",
      buf = bufnr,
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
