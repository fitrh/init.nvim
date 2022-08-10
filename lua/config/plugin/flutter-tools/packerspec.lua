return {
  "akinsho/flutter-tools.nvim",
  requires = "nvim-lua/plenary.nvim",
  config = function()
    require("config.plugin.flutter-tools.setup")
    require("config.plugin.flutter-tools.keymap")
  end,
  ft = "dart",
  event = "BufRead pubspec.yaml",
}
