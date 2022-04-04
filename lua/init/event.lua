local augroup = require("sugar.augroup")

augroup("TrimAndMakeDir", {
  "BufWritePre",
  { command = [[:%s/\s\+$//e]] },
  {
    callback = function()
      require("helper.dir").mk()
    end,
  },
})

augroup("HighlightOnYank", { "TextYankPost", callback = vim.highlight.on_yank })

augroup("CursorlineOnCurrentWindow", {
  {
    { "BufEnter", "WinEnter" },
    callback = function()
      vim.api.nvim_win_set_option(0, "cursorline", true)
    end,
  },
  {
    { "BufLeave", "WinLeave" },
    callback = function()
      vim.api.nvim_win_set_option(0, "cursorline", false)
    end,
  },
})

augroup("RelativeNumberOnCurrentWindow", {
  {
    { "BufEnter", "WinEnter" },
    callback = function()
      if vim.api.nvim_win_get_option(0, "number") then
        vim.api.nvim_win_set_option(0, "relativenumber", true)
      end
    end,
  },
  {
    { "BufLeave", "WinLeave" },
    callback = function()
      vim.api.nvim_win_set_option(0, "relativenumber", false)
    end,
  },
})

augroup("OnTerminalBuffer", {
  "TermOpen",
  {
    callback = function()
      vim.api.nvim_buf_set_option(0, "filetype", "terminal")
    end,
  },
  { command = "startinsert" },
})
