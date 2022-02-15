local capabilities = require("lsp.capability")
local jdtls = require("jdtls")
local setup = require("jdtls.setup")

local jdtls_capability = jdtls.extendedClientCapabilities
capabilities.workspace.configuration = true
jdtls_capability.resolveAdditionalTextEditsSupport = true

local home = os.getenv("HOME")
local env = {
  WORKSPACE = os.getenv("JAVA_WORKSPACE") or ("%s/java"):format(home),
  BASENAME_CWD = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t"),
  RUNTIMES = os.getenv("JAVA_RUNTIMES") or home,
}

local root_files = {
  -- Single-module projects
  {
    "pom.xml", -- Maven
    "settings.gradle", -- Gradle
    "settings.gradle.kts", -- Gradle
  },
  -- Multi-module projects
  { "build.gradle", "build.gradle.kts" },
} or vim.fn.getcwd()

local workspace = ("%s/%s"):format(env.WORKSPACE, env.BASENAME_CWD)

local runtimes = {
  { name = "JavaSE-11", path = ("%s/jdk-11"):format(env.RUNTIMES) },
  { name = "JavaSE-17", path = ("%s/jdk-17"):format(env.RUNTIMES) },
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
    configuration = { runtimes = runtimes },
    implementationsCodeLens = { enabled = true },
    referencesCodeLens = { enabled = true },
    saveActions = { organizeImports = true },
    signatureHelp = { enabled = true },
  },
}

local config = {
  root_dir = setup.find_root(root_files),
  cmd = { "jdtls", workspace },
  capabilities = capabilities,
  handlers = require("lsp.handler").default(),
  settings = settings,
  init_options = {
    extendedClientCapabilities = jdtls_capability,
  },
  on_init = function(client, _)
    client.notify("workspace/didChangeConfiguration", { settings = settings })
  end,
  on_attach = function(client, bufnr)
    require("lsp.attach").with.all(client, bufnr)
    setup.add_commands()
    require("plugin.jdtls.command").attach()
    require("plugin.jdtls.keymap").attach(bufnr)
  end,
  flags = {
    allow_incremental_sync = true,
    server_side_fuzzy_completion = true,
  },
}

return function()
  jdtls.start_or_attach(config)
end
