local capabilities = require("lsp.capability")
local handler = require("lsp.handler")
local attach = require("lsp.attach")
local jdtls = require("jdtls")
local setup = require("jdtls.setup")

local jdtls_capability = jdtls.extendedClientCapabilities
capabilities.workspace.configuration = true
jdtls_capability.resolveAdditionalTextEditsSupport = true

local root_files = {
  -- Single-module projects
  {
    'build.xml', -- Ant
    'pom.xml', -- Maven
    'settings.gradle', -- Gradle
    'settings.gradle.kts', -- Gradle
  },
  -- Multi-module projects
  { 'build.gradle', 'build.gradle.kts' },
} or vim.fn.getcwd()

local config = {
  root_dir = setup.find_root(root_files),
  cmd = { "jdtls", },
  capabilities = capabilities,
  handlers = handler.default(),
  on_attach = function(client, bufnr)
    attach.with_all_extensions(client, bufnr)
    setup.add_commands()
  end,
  flags = {
    allow_incremental_sync = true,
  },
}

jdtls.start_or_attach(config)
