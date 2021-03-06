local config = {}

local FLUTTER_ROOT = os.getenv("FLUTTER_ROOT") or os.getenv("FLUTTER_SDK")
if FLUTTER_ROOT then
  config.flutter_path = ("%s/bin/flutter"):format(FLUTTER_ROOT)
end

config.closing_tags = { prefix = "ﰪ " }

config.lsp = require("config.lsp.server").with("flutter")
if not config.lsp then
  return false
end

config.lsp.settings = { renameFilesWithClasses = "prompt" }
config.lsp.color = {
  enabled = true,
  virtual_text_str = "",
}

require("flutter-tools").setup(config)

local ok, telescope = pcall(require, "telescope")
if ok and telescope.load_extension then
  telescope.load_extension("flutter")
  vim.keymap.set({ "n" }, "<Leader>fl", function()
    telescope.extensions.flutter.commands()
  end, { silent = true, buffer = true })
end
