local env = {
  WORKSPACE = os.getenv("JAVA_WORKSPACE"),
  BASENAME_CWD = vim.fn.fnamemodify(vim.loop.cwd(), ":p:h:t"),
  RUNTIMES = os.getenv("JAVA_RUNTIMES"),
}

local settings = {
  java = { -- https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    codeGeneration = {
      generateComments = true,
      hashCodeEquals = {
        useInstanceof = true,
        useJava7Objects = true,
      },
      useBlocks = true,
    },
    implementationsCodeLens = { enabled = true },
    inlayhints = {
      parameterNames = { enabled = true },
    },
    referencesCodeLens = { enabled = true },
    saveActions = { organizeImports = true },
    signatureHelp = { enabled = true },
    symbols = {
      includeSourceMethodDeclarations = true,
    },
  },
}

if env.RUNTIMES then
  settings.java.configuration = {
    runtimes = {
      { name = "JavaSE-11", path = ("%s/jdk-11"):format(env.RUNTIMES) },
      { name = "JavaSE-17", path = ("%s/jdk-17"):format(env.RUNTIMES) },
    },
  }
end

local capabilities = require("config.lsp.capability")
local jdtls = require("jdtls")
local setup = require("jdtls.setup")
local bin = "jdtls"

local jdtls_capability = jdtls.extendedClientCapabilities
capabilities.workspace.configuration = true
jdtls_capability.resolveAdditionalTextEditsSupport = true
jdtls_capability.progressReportProvider = false -- use $/progress instead

local cmd = { bin }
if env.WORKSPACE then
  local workspace = ("%s/%s"):format(env.WORKSPACE, env.BASENAME_CWD)
  table.insert(cmd, workspace)
end

local config = {
  root_dir = setup.find_root({ "gradlew", "pom.xml" }) or vim.loop.cwd(),
  cmd = cmd,
  capabilities = capabilities,
  settings = settings,
  init_options = {
    extendedClientCapabilities = jdtls_capability,
  },
  on_init = function(client, _)
    client.notify("workspace/didChangeConfiguration", { settings = settings })
  end,
  on_attach = function(client, bufnr)
    require("config.lsp.attach").with.all(client, bufnr)
    setup.add_commands()
    require("config.plugin.jdtls.command").attach(jdtls, bufnr)
    require("config.plugin.jdtls.keymap").attach(jdtls, bufnr)
  end,
  flags = {
    allow_incremental_sync = true,
  },
}
config = require("config.lsp.server").with(bin, config)

return function()
  if not os.getenv("JAVA_HOME") or not config then
    return false
  end

  jdtls.start_or_attach(config)
end
