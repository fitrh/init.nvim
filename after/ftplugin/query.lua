local a = vim.api

a.nvim_buf_set_keymap(0, "n", "q", "", {
  callback = function()
    a.nvim_buf_delete(0, { force = true })
  end,
  silent = true,
  noremap = true,
})
