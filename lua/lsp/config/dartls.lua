local env = {
  DART_SDK = os.getenv("DART_SDK"),
  FLUTTER_ROOT = os.getenv("FLUTTER_ROOT"),
  SNAPSHOT = "bin/snapshots/analysis_server.dart.snapshot",
}

return {
  cmd = { "dart", ("%s/%s"):format(env.DART_SDK, env.SNAPSHOT), "--lsp" },
  capabilities = require("lsp.capability"),
  handlers = require("lsp.handler").default(),
  settings = {
    dart = {
      devToolsBrowser = "default",
      enableServerSnippets = true,
      flutterSdkPath = env.FLUTTER_ROOT,
      previewLsp = true,
      sdkPath = env.DART_SDK,
      renameFilesWithClasses = "prompt",
      triggerSignatureHelpAutomatically = true,
    },
  },
  init_options = {
    closingLabels = true,
    outline = true,
    flutterOutline = true,
  },
  on_attach = require("lsp.attach").with_all_extensions,
}
