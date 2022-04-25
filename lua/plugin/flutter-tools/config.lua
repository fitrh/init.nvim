local env = {
  DART_SDK = os.getenv("DART_SDK"),
  FLUTTER_ROOT = os.getenv("FLUTTER_ROOT") or os.getenv("FLUTTER_SDK"),
}

local setup = require("lsp.config")
local config = {}
config.closing_tags = { prefix = "ﰪ " }

config.lsp = setup.with("flutter")
if not config.lsp then
  return false
end

config.lsp.settings = {
  dart = {
    devToolsBrowser = "default",
    enableServerSnippets = true,
    flutterSdkPath = env.FLUTTER_ROOT,
    previewLsp = true,
    sdkPath = env.DART_SDK,
    renameFilesWithClasses = "prompt",
    triggerSignatureHelpAutomatically = true,
  },
}
config.lsp.color = {
  enabled = true,
  virtual_text_str = config.closing_tags.prefix,
}

require("flutter-tools").setup(config)

local ok, telescope = pcall(require, "telescope")
if ok and telescope.load_extension then
  telescope.load_extension("flutter")
  vim.keymap.set({ "n" }, "<Leader>fl", function()
    telescope.extensions.flutter.commands()
  end, { silent = true, buffer = true })
end
