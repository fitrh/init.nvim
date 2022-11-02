local set = vim.opt_local
set.colorcolumn = ""
set.signcolumn = "yes"

vim.api.nvim_buf_set_keymap(0, "n", "q", "", {
  callback = vim.cmd.helpclose,
  silent = true,
  noremap = true,
})
