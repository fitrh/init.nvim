require("incline").setup({
  window = {
    options = {
      winblend = vim.api.nvim_get_option("pumblend"),
    },
  },
  hide = {
    focused_win = true,
  },
  highlight = {
    groups = {
      InclineNormal = "StatusLine",
      InclineNormalNC = "StatusLineNC",
    },
  },
})
