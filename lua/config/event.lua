local augroup = require("sugar.augroup")

augroup("adaptive_scrolloff", function(autocmd)
  local events = { "BufWinEnter", "WinEnter", "WinScrolled", "VimResized" }
  autocmd(events, "*", function()
    local height = math.ceil(vim.api.nvim_win_get_height(0) / 4)
    local width = math.ceil(vim.api.nvim_win_get_width(0) / 8)

    if height ~= vim.api.nvim_get_option("scrolloff") then
      vim.api.nvim_set_option("scrolloff", math.max(height, 1))
    end

    if width ~= vim.api.nvim_get_option("sidescrolloff") then
      vim.api.nvim_set_option("sidescrolloff", math.max(width, 1))
    end
  end)
end)

augroup("always_relativenumber", function(autocmd)
  autocmd("OptionSet", "number", function()
    vim.api.nvim_win_set_option(0, "relativenumber", vim.v.option_new == "1")
  end)
end)

augroup("cursorline_on_current_window", function(autocmd)
  autocmd({ "BufWinEnter", "WinEnter" }, "*", function()
    vim.api.nvim_win_set_option(0, "cursorline", not vim.w.nocursorline)
  end)

  autocmd("WinLeave", "*", function()
    if not vim.b.keep_cursor_on_leave then
      vim.api.nvim_win_set_option(0, "cursorline", false)
    end
  end)
end)

augroup("highlight_postyank", function(autocmd)
  autocmd("TextYankPost", "*", function()
    vim.highlight.on_yank()
  end)
end)

augroup("macro_recording", function(autocmd)
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

augroup("prewrite_action", function(autocmd)
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

augroup("relativenumber_on_current_window", function(autocmd)
  autocmd({ "BufWinEnter", "WinEnter" }, "*", function()
    if vim.api.nvim_win_get_option(0, "number") then
      vim.api.nvim_win_set_option(0, "relativenumber", true)
    end
  end)

  autocmd("WinLeave", "*", function()
    vim.api.nvim_win_set_option(0, "relativenumber", false)
  end)
end)

augroup("set_tabline", function(autocmd)
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

augroup("shiftwidth_sync", function(autocmd)
  autocmd("OptionSet", "shiftwidth", function()
    local shiftwidth = tonumber(vim.v.option_new)
    if shiftwidth > 0 and shiftwidth < 10000 then
      vim.api.nvim_buf_set_option(0, "tabstop", shiftwidth)
    end
  end)
end)

augroup("terminalbuffer_action", function(autocmd)
  autocmd("TermOpen", "*", function()
    if vim.api.nvim_buf_get_option(0, "filetype") == "" then
      vim.api.nvim_buf_set_option(0, "filetype", "terminal")
    end
    vim.cmd.startinsert()
  end)
end)

augroup("textwidth_sync", function(autocmd)
  autocmd("OptionSet", "textwidth", function()
    vim.api.nvim_buf_set_option(0, "synmaxcol", tonumber(vim.v.option_new))
  end)

  autocmd({ "BufNewFile", "BufEnter" }, "*", function()
    local textwidth = vim.api.nvim_buf_get_option(0, "textwidth")
    vim.api.nvim_buf_set_option(0, "synmaxcol", tonumber(textwidth))
  end)
end)
