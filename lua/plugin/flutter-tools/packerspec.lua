return {
  "akinsho/flutter-tools.nvim",
  requires = "nvim-lua/plenary.nvim",
  config = function()
    require("plugin.flutter-tools.config")
    require("plugin.flutter-tools.keymap")
  end,
  ft = "dart",
  event = "BufRead pubspec.yaml",
  module = "flutter-tools",
}
