return {
  "Saecki/crates.nvim",
  after = "rust-tools.nvim",
  config = function()
    require("config.plugin.crates.setup")
    -- TODO: Use `on_attach` for command and keymap
    -- SEE: https://github.com/Saecki/crates.nvim/pull/65
    require("config.plugin.crates.command")
    require("config.plugin.crates.keymap")
  end,
  event = "BufRead Cargo.toml",
}
