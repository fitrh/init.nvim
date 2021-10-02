return {
  "Saecki/crates.nvim",
  after = "rust-tools.nvim",
  config = function()
    require("plugin.crates.config")
  end,
  event = "BufRead Cargo.toml",
}
