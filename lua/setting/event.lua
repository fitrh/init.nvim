local augroup = require("lib.augroup")
local dir = require("helper.dir")

augroup("TrimAndMakeDir", {
  "BufWritePre",
  { command = [[:%s/\s\+$//e]] },
  { callback = dir.mk },
})

augroup("HighlightOnYank", { "TextYankPost", callback = vim.highlight.on_yank })

augroup("CursorlineOnCurrentWindow", {
  {
    "WinEnter",
    callback = function()
      vim.api.nvim_win_set_option(0, "cursorline", true)
    end,
  },
  {
    "WinLeave",
    callback = function()
      vim.api.nvim_win_set_option(0, "cursorline", false)
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
