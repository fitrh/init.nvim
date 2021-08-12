local M = {}

local keymap = require("keymap.lsp")
local completion = require("lsp.completion")
local diagnostic = require("lsp.diagnostic")
local event = require("lsp.event")

local function default(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  keymap.on_attach(client, bufnr)
  completion.with({ text = true, icon = "default" })
  diagnostic.with({ e = "", w = "", i = "", h = ""})
  event.attach(client)
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
