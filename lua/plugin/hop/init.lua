return {
  "phaazon/hop.nvim",
  config = function()
    require("plugin.hop.config")
  end,
  cmd = {
    "HopWord",
    "HopWordAC",
    "HopWordBC",
    "HopLine",
    "HopLineAC",
    "HopLineBC",
    "HopLineStart",
    "HopLineStartAC",
    "HopLineStartBC",
    "HopChar1",
    "HopChar1AC",
    "HopChar1BC",
    "HopChar2",
    "HopChar2AC",
    "HopChar2BC",
    "HopPattern",
    "HopPatternAC",
    "HopPatternBC",
  },
}
