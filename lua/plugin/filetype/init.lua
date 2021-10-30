return {
  "nathom/filetype.nvim",
  config = function()
    require("plugin.filetype.config")
  end,
  event = { "BufNewFile", "BufRead" },
  module = "filetype",
}
