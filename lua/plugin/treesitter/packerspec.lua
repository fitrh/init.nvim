return {
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("plugin.treesitter.config")
    end,
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    module = "nvim-treesitter",
  },
  {
    "nvim-treesitter/nvim-treesitter-refactor",
    after = "nvim-treesitter",
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter",
  },
}
