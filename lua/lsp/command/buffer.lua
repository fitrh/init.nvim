local M = {}

function M.attach(client, bufnr)
  local command = require("sugar.command")
  local lsp = vim.lsp.buf

  local commands = {}
  commands["textDocument/formatting"] = function()
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

  commands["textDocument/rangeFormatting"] = function()
    command.add(
      "LspFormatRange",
      lsp.range_formatting,
      { buf = bufnr, opts = { range = true } }
    )
  end

  commands["textDocument/rename"] = function()
    command.add("LspRename", function()
      lsp.rename()
    end, { buf = bufnr })
  end

  commands["textDocument/signatureHelp"] = function()
    command.add("LspSignatureHelp", lsp.signature_help, { buf = bufnr })
  end

  commands["textDocument/codeAction"] = function()
    command.add("LspCodeAction", lsp.code_action, { buf = bufnr })
  end

  commands["textDocument/hover"] = function()
    command.add("LspHover", lsp.hover, { buf = bufnr })
  end

  commands["textDocument/declaration"] = function()
    command.add("LspGoToDeclaration", lsp.declaration, { buf = bufnr })
  end

  commands["textDocument/definition"] = function()
    command.add("LspGoToDefinition", lsp.definition, { buf = bufnr })
  end

  commands["textDocument/typeDefinition"] = function()
    command.add("LspGoToTypeDefinition", lsp.type_definition, { buf = bufnr })
  end

  commands["textDocument/implementation"] = function()
    command.add("LspListImplementation", lsp.implementation, { buf = bufnr })
  end

  commands["textDocument/references"] = function()
    command.add("LspListReferences", lsp.references, { buf = bufnr })
  end

  commands["textDocument/documentSymbol"] = function()
    command.add("LspListSymbols", lsp.document_symbol, { buf = bufnr })
  end

  commands["workspace/symbol"] = function()
    command.add(
      "LspListWorkspaceSymbols",
      lsp.workspace_symbol,
      { buf = bufnr }
    )
  end

  commands["textDocument/documentHighlight"] = function()
    command.group({
      prefix = "LspDocument",
      buf = bufnr,
      cmds = {
        { name = "Highlight", cmd = lsp.document_highlight },
        { name = "ClearRefs", cmd = lsp.clear_references },
      },
    })
  end

  commands["textDocument/prepareCallHierarchy"] = function()
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

  for request, fn in pairs(commands) do
    if client.supports_method(request) then
      fn()
    end
  end
end

return M
