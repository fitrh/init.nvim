vim.api.nvim_buf_set_option(0, "textwidth", 79)
if vim.fn.exists(":Telescope") ~= 0 then
  vim.api.nvim_set_keymap(
    "n",
    "<Leader>bb",
    "<Cmd>Telescope buffers<CR>",
    { noremap = true, silent = true }
  )
end
