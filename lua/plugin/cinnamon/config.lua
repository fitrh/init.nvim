require("cinnamon").setup({
  extra_keymaps = true,
  extended_keymaps = true,
  scroll_limit = vim.api.nvim_get_option("lines") * 2,
})
