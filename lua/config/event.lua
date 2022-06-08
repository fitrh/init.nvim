local event = require("sugar.event")
local augroup, autocmd = event.augroup, event.autocmd

augroup("TrimAndMakeDir", {
  autocmd("BufWritePre", "*", {
    function()
      local cursor = vim.api.nvim_win_get_cursor(0)
      vim.cmd([[:%s/\s\+$//e]])
      vim.api.nvim_win_set_cursor(0, cursor)
    end,
    function()
      require("helper.dir").mk()
    end,
  }),
})

augroup("HighlightOnYank", {
  autocmd("TextYankPost", "*", function()
    vim.highlight.on_yank()
  end),
})

augroup("CursorlineOnCurrentWindow", {
  autocmd({ "BufEnter", "WinEnter" }, "*", function()
    vim.api.nvim_win_set_option(0, "cursorline", not vim.w.nocursorline)
  end),
  autocmd({ "BufLeave", "WinLeave" }, "*", function()
    vim.api.nvim_win_set_option(0, "cursorline", false)
  end),
})

augroup("RelativeNumberOnCurrentWindow", {
  autocmd({ "BufEnter", "WinEnter" }, "*", function()
    if vim.api.nvim_win_get_option(0, "number") then
      vim.api.nvim_win_set_option(0, "relativenumber", true)
    end
  end),
  autocmd({ "BufLeave", "WinLeave" }, "*", function()
    vim.api.nvim_win_set_option(0, "relativenumber", false)
  end),
})

augroup("OnTerminalBuffer", {
  autocmd("TermOpen", "*", {
    function()
      if vim.api.nvim_buf_get_option(0, "filetype") == "" then
        vim.api.nvim_buf_set_option(0, "filetype", "terminal")
      end
    end,
    "startinsert",
  }),
})

augroup("SetTabLine", {
  autocmd("TabNew", "*", function()
    vim.api.nvim_set_option(
      "tabline",
      [[%{%v:lua.require("config.option.tabline").draw()%}]]
    )
  end),
})
