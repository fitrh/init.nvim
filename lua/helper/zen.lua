local api = vim.api

local state = {
  zen = false,
  partial = false,
  colorcolumn = api.nvim_win_get_option(0, "colorcolumn"),
  laststatus = api.nvim_get_option("laststatus"),
  showtabline = api.nvim_get_option("showtabline"),
  signcolumn = api.nvim_win_get_option(0, "signcolumn"),
  winwidth = api.nvim_get_option("winwidth"),
}

local option = {}

option.global = {
  { name = "showtabline", disable_value = 0 },
}

option.win = {
  { name = "colorcolumn", disable_value = "" },
  { name = "number" },
  { name = "relativenumber" },
  { name = "signcolumn", disable_value = "no" },
}

option.zen = {
  { name = "laststatus", disable_value = 0 },
}

---Manage option for zen window
---@param zen boolean @zen mode active state
---@param scope boolean|table @manage global and window option
local function opt(zen, scope)
  scope = scope or { global = true, win = true }
  if type(scope) == "boolean" then
    scope = { global = scope, win = scope }
  end

  if scope.global then
    for _, global in ipairs(option.global) do
      local value = zen and global.disable_value
        or state[global.name]
        or not zen
      api.nvim_set_option(global.name, value)
    end
  end

  if scope.win then
    for _, win in ipairs(option.win) do
      local value = zen and win.disable_value or state[win.name] or not zen
      api.nvim_win_set_option(0, win.name, value)
    end
  end
end

-- window padding state
local pad = {
  buf = { left = nil, right = nil },
  win = { left = nil, right = nil },
  cmd = { left = "leftabove", right = "rightbelow" },
  width = 0,
  winhl = "VertSplit:WinSeparatorZen,WinSeparator:WinSeparatorZen",
  opt = {
    buf = {
      { "bufhidden", "wipe" },
      { "buflisted", false },
      { "buftype", "nofile" },
      { "modifiable", false },
    },
    win = {
      { "cursorline", false },
      { "winfixwidth", true },
    },
  },
}

local win = { main = {}, pad = {} }

function win.main.create()
  local cursorpos = api.nvim_win_get_cursor(0)
  -- open current window as new tabpage, before current tabpage
  -- when we exit zen mode, we return to the previous tabpage
  vim.cmd("-tabe %")
  win.main.nr = api.nvim_get_current_win()
  win.main.buf = { nr = api.nvim_buf_get_number(0) }
  api.nvim_win_set_option(win.main.nr, "winhighlight", pad.winhl)
  api.nvim_win_set_cursor(win.main.nr, cursorpos)
  vim.cmd("normal! zz")
  opt(true)
end

function win.main.restore()
  local cursorpos = api.nvim_win_get_cursor(0)
  vim.cmd("tabclose")
  opt(not state.zen)
  api.nvim_set_option("winwidth", state.winwidth)
  api.nvim_win_set_cursor(0, cursorpos)
end

function win.pad.create(side)
  vim.cmd(("%s %dvnew"):format(pad.cmd[side], pad.width))
  pad.buf[side] = api.nvim_buf_get_number(0)
  pad.win[side] = api.nvim_get_current_win()
  api.nvim_win_set_var(pad.win[side], "nocursorline", true)
  api.nvim_win_set_option(pad.win[side], "winhighlight", pad.winhl)
  opt(true, { win = true })

  for _, bufopt in ipairs(pad.opt.buf) do
    api.nvim_buf_set_option(pad.buf[side], bufopt[1], bufopt[2])
  end

  for _, winopt in ipairs(pad.opt.win) do
    api.nvim_win_set_option(pad.win[side], winopt[1], winopt[2])
  end

  api.nvim_set_current_win(win.main.nr)
end

function win.pad.adjust()
  local delta = win.main.buf.tw - win.main.width
  pad.width = math.floor((2 * pad.width - delta) / 2)

  for _, id in pairs(pad.win) do
    api.nvim_win_set_width(id, pad.width)
  end

  api.nvim_set_option("winwidth", pad.width)
end

local function zen(enter)
  local columns = api.nvim_get_option("columns")
  local textwidth = api.nvim_buf_get_option(0, "textwidth")

  if enter then
    win.main.create()
    pad.width = math.floor(columns / 5)

    if columns < textwidth or pad.width <= api.nvim_get_option("winwidth") then
      return
    end
    win.pad.create("left")
    win.pad.create("right")

    win.main.width = api.nvim_win_get_width(win.main.nr)
    win.main.buf.tw = api.nvim_buf_get_option(win.main.buf.nr, "textwidth")

    -- main window must have a width at least equal to 'textwidth'
    if win.main.width >= win.main.buf.tw then
      return
    end
    win.pad.adjust()
    return
  end

  win.main.restore()
end

local Zen = {}

function Zen.enter(args)
  local opts = args or {}
  local enter = not state.zen

  zen(enter)

  local show = opts.show or {}
  for _, zen_opt in ipairs(option.zen) do
    local opt_state = state[zen_opt.name]

    if state.zen then
      api.nvim_set_option(zen_opt.name, opt_state)
    else
      local value = opt_state

      if enter and not show[zen_opt.name] then
        value = zen_opt.disable_value
      end

      api.nvim_set_option(zen_opt.name, value)
    end
  end

  state.zen = enter
  state.partial = opts.partial
end

function Zen.toggle(show)
  show = show or {}

  if not state.zen then
    Zen.enter({ show = show, partial = true })
    return
  end

  for _, zen_opt in ipairs(option.zen) do
    api.nvim_set_option(
      zen_opt.name,
      state.partial and zen_opt.disable_value or state[zen_opt.name]
    )
  end
  state.partial = not state.partial
end

return Zen
