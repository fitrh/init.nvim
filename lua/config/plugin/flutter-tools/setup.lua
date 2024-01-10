local config = {}

local FLUTTER_ROOT = os.getenv("FLUTTER_ROOT") or os.getenv("FLUTTER_SDK")
if FLUTTER_ROOT and FLUTTER_ROOT ~= "" then
  config.flutter_path = ("%s/bin/flutter"):format(FLUTTER_ROOT)
end

config.root_patterns = { "pubspec.yaml" }
config.closing_tags = { prefix = "ﰪ " }
config.dev_log = { open_cmd = "botright 10new" }

config.lsp = require("config.lsp.server").with("flutter")
if not config.lsp then
  return false
end

config.lsp.settings = { renameFilesWithClasses = "prompt" }
config.lsp.color = {
  enabled = true,
  virtual_text_str = "▣",
}

require("flutter-tools").setup(config)

local ok, telescope = pcall(require, "telescope")
if ok and telescope.load_extension then
  telescope.load_extension("flutter")
  vim.api.nvim_set_keymap("n", "<Leader>fl", "", {
    callback = function()
      require("telescope").extensions.flutter.commands()
    end,
    noremap = true,
    silent = true,
  })
end
