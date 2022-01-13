local M = {}

function M.attach(client)
  local capable = client.resolved_capabilities
  local command = require("lib.command")

  if capable.document_formatting then
    local function timeout(args)
      local default = 5000
      args = args ~= "" and args or default
      if type(args) == "string" then
        args = string.gsub(args, [["]], "")
      end
      return tonumber(args) or default
    end

    command.group({
      prefix = "LspFormat",
      buf = true,
      cmds = {
        { cmd = vim.lsp.buf.formatting },
        {
          name = "Seq",
          cmd = function(opts)
            vim.lsp.buf.formatting_seq_sync({}, timeout(opts.args))
          end,
          opts = { nargs = 1 },
        },
        {
          name = "Sync",
          cmd = function(opts)
            vim.lsp.buf.formatting_sync({}, timeout(opts.args))
          end,
          opts = { nargs = 1 },
        },
      },
    })
  end

  if capable.rename then
    command.add("LspRename", function()
      vim.lsp.buf.rename()
    end, { buf = true })
  end

  if capable.signature_help then
    command.add("LspSignatureHelp", vim.lsp.buf.signature_help, { buf = true })
  end

  if capable.code_action then
    command.add("LspCodeAction", vim.lsp.buf.code_action, { buf = true })
  end

  if capable.hover then
    command.add("LspHover", vim.lsp.buf.hover, { buf = true })
  end

  if capable.declaration then
    command.add("LspGoToDeclaration", vim.lsp.buf.declaration, { buf = true })
  end

  if capable.goto_definition then
    command.add("LspGoToDefinition", vim.lsp.buf.definition, { buf = true })
  end

  if capable.type_definition then
    command.add(
      "LspGoToTypeDefinition",
      vim.lsp.buf.type_definition,
      { buf = true }
    )
  end

  if capable.implementation then
    command.add(
      "LspListImplementation",
      vim.lsp.buf.implementation,
      { buf = true }
    )
  end

  if capable.find_references then
    command.add("LspListReferences", vim.lsp.buf.references, { buf = true })
  end

  if capable.document_symbol then
    command.add("LspListSymbols", vim.lsp.buf.document_symbol, { buf = true })
  end

  if capable.document_highlight then
    command.group({
      prefix = "LspDocument",
      buf = true,
      cmds = {
        { name = "Highlight", cmd = vim.lsp.buf.document_highlight },
        { name = "ClearRefs", cmd = vim.lsp.buf.clear_references },
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
            vim.lsp.buf.incoming_calls()
          end,
        },
        {
          name = "Outgoing",
          cmd = function()
            vim.lsp.buf.outging_calls()
          end,
        },
      },
    })
  end
end

return M
