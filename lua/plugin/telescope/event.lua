local augroup = require("lib.augroup")

augroup("OnTelescopePrompt", {
  "FileType",
  pattern = "TelescopePrompt",
  callback = function()
    vim.api.nvim_win_set_option(0, "cursorline", false)
  end,
})
