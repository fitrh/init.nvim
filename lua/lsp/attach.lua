local M = {}

local keymap = require("keymap.lsp")
local event = require("lsp.event")
local command = {
  buffer = require("lsp.command.buffer"),
  codelens = require("lsp.command.codelens"),
  diagnostic = require("lsp.command.diagnostic"),
}
local ui = { diagnostic = require("lsp.ui.diagnostic") }

local function default(client, bufnr)
  if client.resolved_capabilities.code_lens then
    vim.lsp.codelens.refresh()
  end
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  command.buffer.attach(client)
  command.codelens.attach(client)
  command.diagnostic.attach()
  keymap.attach(bufnr)
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

function M.without_formatting(client)
  client.resolved_capabilities.document_formatting = false
  client.resolved_capabilities.document_range_formatting = false
end

return M
