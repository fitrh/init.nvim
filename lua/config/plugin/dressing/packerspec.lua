return {
  "stevearc/dressing.nvim",
  requires = { "nvim-telescope/telescope.nvim", module = "telescope" },
  config = function()
    require("config.plugin.dressing.setup")
  end,
  event = { "BufReadPost", "BufNewFile" },
}
