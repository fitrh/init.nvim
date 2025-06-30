local augroup = require("sugar.augroup")
local api = vim.api
local o = { -- SEE: https://github.com/neovim/neovim/pull/23670
  set = api.nvim_set_option_value, -- set option value
  get = api.nvim_get_option_value, -- get option value
}
local get_option = api.nvim_get_option
local set_option = api.nvim_set_option
local win_get_option = api.nvim_win_get_option
local win_set_option = api.nvim_win_set_option
local buf_get_option = api.nvim_buf_get_option
local buf_set_option = api.nvim_buf_set_option
local err

-- TODO: Run `:checktime` on `FocusGained,BufEnter`, SEE: https://github.com/k-37/hedgehog-is-diy-vim-experiment/blob/main/.vim/vimrc#L250
-- TODO: map q to close on preview widow BufWinEnter
-- TODO: Handle cmdline-window
local function is_normal_buf(nr)
  return buf_get_option(nr, "buftype") == "" and buf_get_option(nr, "buflisted")
end

-- TODO: Separate autocmd for UIEnter
--       UIEnter autocmd should be clean up immediately with `return true` at the end of callback
-- NOTE: Added UIEnter for handling `nvim file`
-- NOTE: Added WinResized SEE: https://github.com/neovim/neovim/pull/21161
local WinChanged = { "UIEnter", "BufWinEnter", "WinEnter", "WinResized" }
augroup("adaptive_scrolloff", function(autocmd)
  autocmd(WinChanged, "*", function()
    -- TODO: check normal buffer
    local height = math.ceil(api.nvim_win_get_height(0) * 0.1)

    if height ~= get_option("scrolloff") then
      set_option("scrolloff", math.max(height, 1))
    end
  end)
end)

augroup("adaptive_pumheight", function(autocmd)
  autocmd(WinChanged, "*", function(args)
    if not is_normal_buf(args.buf) then
      return
    end

    local height = math.ceil(api.nvim_win_get_height(0) * 0.3)
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
  autocmd("InsertEnter", "*", function(ctx)
    local val = vim.api.nvim_get_option_value("colorcolumn", {
      filetype = vim.api.nvim_get_option_value("filetype", { buf = ctx.buf }),
    })

    vim.api.nvim_set_option_value("colorcolumn", val ~= "" and val or "+1", {
      scope = "local",
      win = 0,
    })
  end)

  autocmd({ "BufWinEnter", "InsertLeave" }, "*", function()
    local localwin = { scope = "local", win = 0 }
    vim.api.nvim_set_option_value("colorcolumn", "", localwin)
  end)
end)

augroup("cursorline_on_current_window", function(autocmd)
  local function cursorlineopt(val)
    local localwin = { scope = "local", win = 0 }
    vim.api.nvim_set_option_value("cursorlineopt", val, localwin)
  end

  autocmd({ "BufWinEnter", "WinEnter", "InsertLeave" }, "*", function(ctx)
    if not is_normal_buf(ctx.buf) then
      return
    end
    cursorlineopt("both")
  end)

  autocmd({ "WinLeave", "InsertEnter" }, "*", function(ctx)
    if not is_normal_buf(ctx.buf) then
      return
    end
    -- TODO: don't hide in diff-mode or 'cursorbind' is on
    -- TODO: check for 'scrollbind' and 'cursorbind'
    if vim.wo.cursorbind or vim.wo.scrollbind then
      return
    end

    cursorlineopt("number")
  end)
end)

augroup("highlight_postyank", function(autocmd)
  autocmd("TextYankPost", "*", function()
    local hl = vim.hl or vim.highlight -- SEE https://github.com/neovim/neovim/pull/30840
    hl.on_yank()
  end)
end)

augroup("macro_recording", function(autocmd)
  local NOTIFY_RECORD = "notify_record"
  vim.api.nvim_set_var(NOTIFY_RECORD, nil)
  local opts = { title = "Macro", icon = "", timeout = 500 }
  opts.on_close = function()
    vim.api.nvim_set_var(NOTIFY_RECORD, nil)
  end

  -- TODO: `set cmdheight=1` when recording macro
  autocmd("RecordingEnter", "*", function()
    local msg = ("󰑋 Recording macro @%s"):format(vim.fn.reg_recording())
    local old_record = vim.api.nvim_get_var(NOTIFY_RECORD)
    opts.replace = old_record and old_record.id

    local new_record = vim.notify(msg, vim.log.levels.INFO, opts)
    vim.api.nvim_set_var(NOTIFY_RECORD, new_record)
  end)

  autocmd("RecordingLeave", "*", function()
    local msg = (" Macro recorded @%s"):format(vim.v.event.regname)
    local old_record = vim.api.nvim_get_var(NOTIFY_RECORD)
    opts.replace = old_record and old_record.id

    local new_record = vim.notify(msg, vim.log.levels.WARN, opts)
    vim.api.nvim_set_var(NOTIFY_RECORD, new_record)
  end)
end)

augroup("prewrite_action", function(autocmd)
  -- TODO: Convert to buflocal, wrap with BufWinEnter
  -- TODO: Add ignored filetypes, e.g. markdown, since trailing whitespace might
  --       be intentional
  autocmd("BufWritePre", "*", function(args)
    local a = vim.api
    if not a.nvim_get_option_value("modifiable", { buf = args.buf }) then
      return
    end

    local cursor = a.nvim_win_get_cursor(0)
    a.nvim_cmd({ cmd = "undojoin", mods = { emsg_silent = true } }, {})
    a.nvim_cmd({
      cmd = "substitute",
      range = { 1, a.nvim_buf_line_count(0) },
      args = { [[/\s\+$//e]] },
      mods = { silent = true, keepjumps = true, keeppatterns = true },
    }, {})
    a.nvim_win_set_cursor(0, cursor)
  end)
end)

augroup("relativenumber_on_current_window", function(autocmd)
  autocmd({ "BufWinEnter", "WinEnter", "InsertLeave" }, "*", function(args)
    local buf = args.buf
    local buftype = o.get("buftype", { buf = buf })
    if
      not is_normal_buf(buf)
      and buftype ~= "quickfix"
      and buftype ~= "help"
    then
      return
    end

    if win_get_option(0, "number") then
      win_set_option(0, "relativenumber", true)
    end
  end)

  autocmd({ "WinLeave", "InsertEnter" }, "*", function(args)
    local buf = args.buf
    local buftype = o.get("buftype", { buf = buf })
    if
      not is_normal_buf(buf)
      and buftype ~= "quickfix"
      and buftype ~= "help"
    then
      return
    end

    if win_get_option(0, "relativenumber") then
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
    local tlist = vim.g.tlist or {}
    tlist[#tlist + 1] = { i = #tlist + 1, data = args }
    vim.g.tlist = tlist
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
