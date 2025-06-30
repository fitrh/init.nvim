vim.api.nvim_set_hl(0, "@punctuation.special.diff", {})
vim.api.nvim_set_hl(0, "@string.special.path.diff", {})

-- split window to show two-line from-file/to-file header
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("after/ftplugin/diff", {}),
  callback = function()
    vim.schedule(function()
      local ex = vim.api.nvim_cmd
      ex({ cmd = "split", range = { 2 }, mods = { split = "aboveleft" } }, {})
      ex({ cmd = "wincmd", args = { "p" } }, {}) -- move to previous window
      local scrolloff = vim.api.nvim_get_option_value("scrolloff", { win = 0 })
      ex({ cmd = "normal", args = { scrolloff + 2 .. "j" } }, {})
      ex({ cmd = "normal", args = { "zt" } }, {})
    end)
  end,
  once = true,
  buffer = 0,
})
