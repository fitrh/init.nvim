local M = {}

function M.attach(client, bufnr)
  local command = require("sugar.command")
  local lsp = vim.lsp.buf

  local commands = {}
  commands.documentFormattingProvider = function()
    local default = 5000

    command.group({
      prefix = "LspFormat",
      opts = { nargs = "?" },
      buf = bufnr,
      cmds = {
        {
          cmd = function(opts)
            local timeout = tonumber(opts.fargs[1]) or default
            lsp.format({ bufnr = bufnr, timeout_ms = timeout })
          end,
        },
        {
          name = "Async",
          cmd = function()
            lsp.format({ bufnr = bufnr, async = true })
          end,
        },
      },
    })
  end

  commands.documentRangeFormattingProvider = function()
    command.add(
      "LspFormatRange",
      lsp.range_formatting,
      { buf = bufnr, opts = { range = true } }
    )
  end

  commands.renameProvider = function()
    command.add("LspRename", function()
      lsp.rename()
    end, { buf = bufnr })
  end

  commands.signatureHelpProvider = function()
    command.add("LspSignatureHelp", lsp.signature_help, { buf = bufnr })
  end

  commands.codeActionProvider = function()
    command.add("LspCodeAction", function()
      lsp.code_action()
    end, { buf = bufnr })
  end

  commands.hoverProvider = function()
    command.add("LspHover", lsp.hover, { buf = bufnr })
  end

  commands.declarationProvider = function()
    command.add("LspGoToDeclaration", lsp.declaration, { buf = bufnr })
  end

  commands.definitionProvider = function()
    command.add("LspGoToDefinition", lsp.definition, { buf = bufnr })
  end

  commands.typeDefinitionProvider = function()
    command.add("LspGoToTypeDefinition", lsp.type_definition, { buf = bufnr })
  end

  commands.implementationProvider = function()
    command.add("LspListImplementation", lsp.implementation, { buf = bufnr })
  end

  commands.referencesProvider = function()
    command.add("LspListReferences", lsp.references, { buf = bufnr })
  end

  commands.documentSymbolProvider = function()
    command.add("LspListSymbols", lsp.document_symbol, { buf = bufnr })
  end

  commands.workspaceSymbolProvider = function()
    command.add(
      "LspListWorkspaceSymbols",
      lsp.workspace_symbol,
      { buf = bufnr }
    )
  end

  commands.documentHighlightProvider = function()
    command.group({
      prefix = "LspDocument",
      buf = bufnr,
      cmds = {
        { name = "Highlight", cmd = lsp.document_highlight },
        { name = "ClearRefs", cmd = lsp.clear_references },
      },
    })
  end

  commands.callHierarchyProvider = function()
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

  for capability, fn in pairs(commands) do
    if client.server_capabilities[capability] then
      fn()
    end
  end
end

return M
