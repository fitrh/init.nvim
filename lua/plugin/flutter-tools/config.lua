local env = {
  DART_SDK = os.getenv("DART_SDK"),
  FLUTTER_ROOT = os.getenv("FLUTTER_ROOT") or os.getenv("FLUTTER_SDK"),
}

require("flutter-tools").setup({
  closing_tags = { prefix = "ﰪ " },
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
    color = {
      enabled = true,
      foreground = false,
      background = true,
      virtual_text = false,
    },
  },
})

local ok, telescope = pcall(require, "telescope")
if ok and telescope.load_extension then
  telescope.load_extension("flutter")
end
