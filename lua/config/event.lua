local augroup = require("sugar.augroup")

augroup("TrimAndMakeDir", function(autocmd)
  autocmd("BufWritePre", "*", {
    function()
      local cursor = vim.api.nvim_win_get_cursor(0)
      vim.cmd([[:%s/\s\+$//e]])
      vim.api.nvim_win_set_cursor(0, cursor)
    end,
    function()
      require("helper.dir").mk()
    end,
  })
end)

augroup("HighlightOnYank", function(autocmd)
  autocmd("TextYankPost", "*", function()
    vim.highlight.on_yank()
  end)
end)

augroup("CursorlineOnCurrentWindow", function(autocmd)
  autocmd({ "BufEnter", "WinEnter" }, "*", function()
    vim.api.nvim_win_set_option(0, "cursorline", not vim.w.nocursorline)
  end)

  autocmd({ "BufLeave", "WinLeave" }, "*", function()
    if vim.b.keep_cursor_on_leave then
      return
    end
    vim.api.nvim_win_set_option(0, "cursorline", false)
  end)
end)

augroup("RelativeNumberOnCurrentWindow", function(autocmd)
  autocmd({ "BufWinEnter", "WinEnter" }, "*", function()
    if vim.api.nvim_win_get_option(0, "number") then
      vim.api.nvim_win_set_option(0, "relativenumber", true)
    end
  end)

  autocmd("WinLeave", "*", function()
    vim.api.nvim_win_set_option(0, "relativenumber", false)
  end)
end)

augroup("AlwaysRelativeNumber", function(autocmd)
  autocmd("OptionSet", "number", function()
    local v = vim.api.nvim_win_get_option(0, "number")
    vim.api.nvim_win_set_option(0, "relativenumber", v)
  end)
end)

augroup("OnTerminalBuffer", function(autocmd)
  autocmd("TermOpen", "*", function()
    if vim.api.nvim_buf_get_option(0, "filetype") == "" then
      vim.api.nvim_buf_set_option(0, "filetype", "terminal")
    end
    vim.cmd.startinsert()
  end)
end)

augroup("SetTabLine", function(autocmd)
  local tabline = [[%{%v:lua.require("config.option.tabline").draw()%}]]

  autocmd("UIEnter", "*", function()
    if #vim.api.nvim_list_tabpages() > 1 then
      vim.api.nvim_set_option("tabline", tabline)
    end
  end)

  autocmd("TabNew", "*", function()
    vim.api.nvim_set_option("tabline", tabline)
  end)
end)

augroup("SyncWithTextwidth", function(autocmd)
  autocmd("OptionSet", "textwidth", function()
    vim.api.nvim_buf_set_option(0, "synmaxcol", tonumber(vim.v.option_new))
  end)

  autocmd({ "BufNewFile", "BufEnter" }, "*", function()
    local textwidth = vim.api.nvim_buf_get_option(0, "textwidth")
    vim.api.nvim_buf_set_option(0, "synmaxcol", tonumber(textwidth))
  end)
end)

augroup("SyncWithShiftwidth", function(autocmd)
  autocmd("OptionSet", "shiftwidth", function()
    vim.api.nvim_buf_set_option(0, "tabstop", tonumber(vim.v.option_new))
  end)
end)

augroup("MacroRecording", function(autocmd)
  local opts = { title = "Macro", icon = "", timeout = 250 }

  autocmd("RecordingEnter", "*", function()
    local msg = (" 壘Recording @%s"):format(vim.fn.reg_recording())
    vim.notify(msg, vim.log.levels.INFO, opts)
  end)

  autocmd("RecordingLeave", "*", function()
    local msg = ("  Recorded @%s"):format(vim.v.event.regname)
    vim.notify(msg, vim.log.levels.INFO, opts)
  end)
end)
