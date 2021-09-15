return {
  "karb94/neoscroll.nvim",
  config = function()
    require("plugin.neoscroll.config")
  end,
  keys = { "<C-u>", "<C-d>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
}
