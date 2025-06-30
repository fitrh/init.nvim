require("nvim-highlight-colors").setup({ render = "background" })
vim.api.nvim_set_keymap("n", "<Leader>cc", "", {
  callback = function()
    require("nvim-highlight-colors").toggle()
  end,
  noremap = true,
  silent = true,
})
