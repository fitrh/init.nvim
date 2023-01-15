return {
  {
    "folke/tokyonight.nvim",
    as = "colorscheme/tokyonight",
    config = function()
      require("config.plugin.colorscheme.tokyonight.setup")
    end,
    event = { "User TokyoNightPre" },
  },
  {
    "rebelot/kanagawa.nvim",
    as = "colorscheme/kanagawa",
    config = function()
      require("config.plugin.colorscheme.kanagawa.setup")
    end,
    event = { "User KanagawaPre" },
  },
  {
    "marko-cerovac/material.nvim",
    as = "colorscheme/material",
    config = function()
      require("config.plugin.colorscheme.material.setup")
    end,
    event = { "User MaterialPre" },
  },
  {
    "projekt0n/github-nvim-theme",
    as = "colorscheme/github",
    config = function()
      require("config.plugin.colorscheme.github.setup")
    end,
    event = { "User GithubPre" },
  },
  {
    "rose-pine/neovim",
    as = "colorscheme/rose-pine",
    config = function()
      require("config.plugin.colorscheme.rose-pine.setup")
    end,
    event = { "User RosePinePre" },
  },
  {
    "ellisonleao/gruvbox.nvim",
    as = "colorscheme/gruvbox",
    config = function()
      require("config.plugin.colorscheme.gruvbox.setup")
    end,
    event = { "User GruvboxPre" },
  },
  {
    "NTBBloodbath/doom-one.nvim",
    as = "colorscheme/doom-one",
    config = function()
      require("config.plugin.colorscheme.doom-one.setup")
    end,
    event = { "User DoomOnePre" },
  },
}
