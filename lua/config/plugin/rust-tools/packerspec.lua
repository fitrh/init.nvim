return {
  "simrat39/rust-tools.nvim",
  config = function()
    require("config.plugin.rust-tools.setup")
  end,
  ft = { "rust" },
}
