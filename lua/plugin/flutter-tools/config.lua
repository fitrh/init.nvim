local env = {
  DART_SDK = os.getenv("DART_SDK"),
  FLUTTER_ROOT = os.getenv("FLUTTER_ROOT") or os.getenv("FLUTTER_SDK"),
}

require("flutter-tools").setup({
  lsp = {
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
    on_attach = require("lsp.attach").with.all,
  },
})

local ok, telescope = pcall(require, "telescope")
if ok and telescope.load_extension then
  telescope.load_extension("flutter")
end
