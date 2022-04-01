return {
  "Saecki/crates.nvim",
  after = "rust-tools.nvim",
  config = function()
    require("plugin.crates.config")
    require("plugin.crates.command")
    require("plugin.crates.keymap")
  end,
  event = "BufRead Cargo.toml",
}
