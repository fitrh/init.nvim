local augroup = require("sugar.augroup")
local api = vim.api
local get_option = api.nvim_get_option
local set_option = api.nvim_set_option
local win_get_option = api.nvim_win_get_option
local win_set_option = api.nvim_win_set_option
local buf_get_option = api.nvim_buf_get_option
local buf_set_option = api.nvim_buf_set_option

local function is_normal_buf(nr)
  return buf_get_option(nr, "buftype") == "" and buf_get_option(nr, "buflisted")
end

local WinChanged = { "BufWinEnter", "WinEnter", "WinScrolled", "VimResized" }
augroup("adaptive_scrolloff", function(autocmd)
  autocmd(WinChanged, "*", function()
    local height = math.ceil(api.nvim_win_get_height(0) / 4)
    local width = math.ceil(api.nvim_win_get_width(0) / 8)

    if height ~= get_option("scrolloff") then
      set_option("scrolloff", math.max(height, 1))
    end

    if width ~= get_option("sidescrolloff") then
      set_option("sidescrolloff", math.max(width, 1))
    end
  end)
end)

augroup("adaptive_pumheight", function(autocmd)
  autocmd(WinChanged, "*", function(args)
    if not is_normal_buf(args.buf) then
      return
    end

    local height = math.ceil(api.nvim_win_get_height(0) / 3)
    if height ~= get_option("pumheight") then
      set_option("pumheight", math.max(height, 3))
    end
  end)
end)

augroup("always_relativenumber", function(autocmd)
  autocmd("OptionSet", "number", function()
    win_set_option(0, "relativenumber", vim.v.option_new)
  end)

  autocmd("OptionSet", "relativenumber", function()
    win_set_option(0, "number", vim.v.option_new)
  end)
end)

augroup("colorcolumn_on_insert", function(autocmd)
  autocmd("InsertEnter", "*", function()
    vim.api.nvim_set_option_value("colorcolumn", "+1", { win = 0 })
  end)

  autocmd("InsertLeave", "*", function()
    vim.api.nvim_set_option_value("colorcolumn", "", { win = 0 })
  end)
end)

augroup("cursorline_on_current_window", function(autocmd)
  autocmd({ "BufWinEnter", "WinEnter" }, "*", function()
    win_set_option(0, "cursorline", not vim.w.nocursorline)
  end)

  autocmd("WinLeave", "*", function(args)
    if is_normal_buf(args.buf) and not vim.b.keep_cursor_on_leave then
      win_set_option(0, "cursorline", false)
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
  autocmd("BufWritePre", "*", function()
    local cursor = api.nvim_win_get_cursor(0)
    vim.cmd([[:%s/\s\+$//e]])
    api.nvim_win_set_cursor(0, cursor)
  end)
end)

augroup("relativenumber_on_current_window", function(autocmd)
  autocmd({ "BufWinEnter", "WinEnter" }, "*", function(args)
    if is_normal_buf(args.buf) and win_get_option(0, "number") then
      win_set_option(0, "relativenumber", true)
    end
  end)

  autocmd("WinLeave", "*", function(args)
    if is_normal_buf(args.buf) and win_get_option(0, "relativenumber") then
      win_set_option(0, "relativenumber", false)
    end
  end)
end)

augroup("set_tabline", function(autocmd)
  local tabline = [[%{%v:lua.require("config.option.tabline").draw()%}]]

  autocmd("UIEnter", "*", function()
    if #api.nvim_list_tabpages() > 1 then
      if api.nvim_get_option_value("tabline", {}) == "" then
        set_option("tabline", tabline)
      end
    end
    return true
  end)

  autocmd("TabNew", "*", function()
    if api.nvim_get_option_value("tabline", {}) == "" then
      set_option("tabline", tabline)
    end
    return true
  end)
end)

augroup("shiftwidth_sync", function(autocmd)
  autocmd("OptionSet", "shiftwidth", function(args)
    local shiftwidth = vim.v.option_new
    if shiftwidth > 0 and shiftwidth < 10000 then
      buf_set_option(args.buf, "tabstop", shiftwidth)
    end
  end)

  autocmd("OptionSet", "tabstop", function(args)
    buf_set_option(args.buf, "shiftwidth", 0)
  end)
end)

augroup("terminalbuffer_action", function(autocmd)
  autocmd("TermOpen", "*", function(args)
    if buf_get_option(args.buf, "filetype") == "" then
      buf_set_option(args.buf, "filetype", "terminal")
    end
    vim.cmd.startinsert()
  end)
end)

augroup("textwidth_sync", function(autocmd)
  autocmd("OptionSet", "textwidth", function(args)
    buf_set_option(args.buf, "synmaxcol", vim.v.option_new)
  end)

  autocmd({ "BufNewFile", "BufEnter" }, "*", function(args)
    local textwidth = buf_get_option(args.buf, "textwidth")
    buf_set_option(args.buf, "synmaxcol", textwidth)
  end)
end)
