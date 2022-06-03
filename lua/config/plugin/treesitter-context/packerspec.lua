return {
  "nvim-treesitter/nvim-treesitter-context",
  after = "nvim-treesitter",
  requires = {
    { "nvim-treesitter/nvim-treesitter", module = "nvim-treesitter" },
  },
  config = function()
    require("treesitter-context").setup({})
  end,
}
