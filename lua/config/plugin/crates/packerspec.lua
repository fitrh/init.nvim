return {
  "Saecki/crates.nvim",
  after = "rust-tools.nvim",
  config = function()
    require("config.plugin.crates.setup")
    require("config.plugin.crates.command")
    require("config.plugin.crates.keymap")
  end,
  event = "BufRead Cargo.toml",
}
