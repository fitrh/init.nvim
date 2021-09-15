return {
  "phaazon/hop.nvim",
  config = function()
    require("plugin.hop.config")
  end,
  cmd = {
    "HopWord",
    "HopLine",
    "HopLineStart",
    "HopChar1",
    "HopChar2",
    "HopPattern",
  },
}
