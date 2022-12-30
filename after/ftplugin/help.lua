local set = vim.opt_local
set.colorcolumn = ""
set.signcolumn = "yes"

vim.api.nvim_buf_set_keymap(0, "n", "q", "", {
  callback = function()
    vim.api.nvim_buf_delete(0, { force = true })
  end,
  silent = true,
  noremap = true,
})
