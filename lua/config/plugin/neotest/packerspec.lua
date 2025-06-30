return {
  "nvim-neotest/neotest",
  requires = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-treesitter/nvim-treesitter" },
    {
      "rcasia/neotest-bash",
      module = "neotest-bash",
      after = "neotest",
    },
    {
      "nvim-neotest/neotest-go",
      module = "neotest-go",
      after = "neotest",
    },
    {
      "sidlatau/neotest-dart",
      module = "neotest-dart",
      after = "neotest",
    },
    {
      "marilari88/neotest-vitest",
      module = "neotest-vitest",
      after = "neotest",
    },
    {
      "lawrence-laz/neotest-zig",
      module = "neotest-zig",
      after = "neotest",
    },
  },
  config = function()
    require("config.plugin.neotest.setup")
  end,
  cmd = "Neotest",
  module = "neotest",
}
