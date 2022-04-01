return {
  "stevearc/dressing.nvim",
  requires = { "nvim-telescope/telescope.nvim", module = "telescope" },
  config = function()
    require("plugin.dressing.config")
  end,
  event = { "BufReadPost", "BufNewFile" },
  module = "dressing",
}
