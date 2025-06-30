return {
  "windwp/nvim-ts-autotag",
  config = function()
    require("config.plugin.ts-autotag.setup")
  end,
  after = "nvim-treesitter",
  -- event = { "BufReadPre", "BufNewFile" },
}
