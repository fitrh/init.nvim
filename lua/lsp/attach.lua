local M = {}

local keymap = require("keymap.lsp")
local command = require("lsp.command")
local event = require("lsp.event")
local ui = { diagnostic = require("lsp.ui.diagnostic") }

local function default(client, bufnr)
  if client.resolved_capabilities.code_lens then
    vim.lsp.codelens.refresh()
  end
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  command.attach(client, bufnr)
  keymap.attach(client, bufnr)
  event.attach(client)
  ui.diagnostic.attach()
end

function M.with_basic_config(client, bufnr)
  default(client, bufnr)
end

function M.with_lsp_status(client)
  local status = require("lsp-status")
  local config = require("plugin.lspstatus.config")
  status.register_progress()
  status.on_attach(client)
  status.config(config)
end

function M.with_lsp_signature()
  local signature = {
    plugin = require("lsp_signature"),
    config = require("plugin.lspsignature.config"),
  }
  signature.plugin.on_attach(signature.config)
end

function M.with_all_extensions(client, bufnr)
  default(client, bufnr)
  M.with_lsp_signature()
  M.with_lsp_status(client)
end

return M
