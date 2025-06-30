return {
  "akinsho/pubspec-assist.nvim",
  requires = { "nvim-lua/plenary.nvim", module = "plenary" },
  config = function()
    require("pubspec-assist").setup()
  end,
  event = { "BufRead pubspec.yaml" },
}
