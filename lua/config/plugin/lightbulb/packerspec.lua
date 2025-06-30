return {
  "kosayoda/nvim-lightbulb",
  config = function()
    require("config.plugin.lightbulb.setup")
  end,
  -- TODO: use `LspNotify`
  -- SEE: https://github.com/neovim/neovim/pull/24128
  event = { "LspAttach" },
}
