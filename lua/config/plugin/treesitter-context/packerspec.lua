return {
  "nvim-treesitter/nvim-treesitter-context",
  after = "nvim-treesitter",
  config = function()
    require("treesitter-context").setup({
      enable = false,
    })
  end,
}
