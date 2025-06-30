local M = {}

---@param client vim.lsp.Client
---@param bufnr number
function M.attach(client, bufnr)
  local capable = client.server_capabilities
  if not capable then
    return
  end

  local support = client.supports_method
  local lsp = vim.lsp
  local augroup = require("sugar.augroup")

  if capable.semanticTokensProvider then
    augroup({ "semantic_token_mod", false }, function(autocmd)
      autocmd("LspTokenUpdate", bufnr, function()
        local hi = vim.api.nvim_set_hl
        hi(0, "@lsp.type.comment.dart", {})
        hi(0, "@lsp.type.comment.go", {})
        hi(0, "@lsp.type.comment.lua", {})
        hi(0, "@lsp.type.comment.zig", {})
        return true
      end)
    end)
  end

  -- TODO: remove, use keymap instead
  if capable.documentHighlightProvider then
    augroup({ "highlight_references", false }, function(autocmd)
      autocmd("CursorHold", bufnr, lsp.buf.document_highlight)

      local event = { "CursorMoved", "InsertEnter", "BufLeave" }
      autocmd(event, bufnr, lsp.buf.clear_references)
    end)
  end

  if capable.documentFormattingProvider then
    augroup({ "format_on_save", false }, function(autocmd)
      autocmd("BufWritePre", bufnr, function()
        local format_on_save = vim.b[bufnr].format_on_save
        if not format_on_save then
          return
        end

        if type(format_on_save) ~= "table" then
          format_on_save = {}
        end

        lsp.buf.format({
          timeout_ms = format_on_save.timeout_ms or 1000,
          bufnr = bufnr,
        })
      end)
    end)
  end

  if support("textDocument/codeLens", { bufnr = bufnr }) then
    -- if capable.codeLensProvider then
    augroup({ "codelens_refresh", false }, function(autocmd)
      local event = { "BufEnter", "BufLeave", "InsertEnter", "InsertLeave" }
      autocmd(event, bufnr, function(args)
        lsp.codelens.refresh({ bufnr = args.buf }) -- set bufnr opts to avoid refreshing all buffer
      end)
    end)
  end
end

return M
