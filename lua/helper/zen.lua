local api = vim.api

local state = {
  zen = false,
  partial = false,
  colorcolumn = api.nvim_win_get_option(0, "colorcolumn"),
  laststatus = api.nvim_get_option("laststatus"),
  showtabline = api.nvim_get_option("showtabline"),
  signcolumn = api.nvim_win_get_option(0, "signcolumn"),
}

local option = {}

option.global = {
  { name = "showtabline", disable_value = 0 },
}

option.window = {
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
    for _, win in ipairs(option.window) do
      local value = zen and win.disable_value or state[win.name] or not zen
      api.nvim_win_set_option(0, win.name, value)
    end
  end
end

-- window padding state
local pad = {
  exist = false,
  buf = { left = nil, right = nil },
  win = { left = nil, right = nil },
  cmd = { left = "leftabove", right = "rightbelow" },
  width = 0,
  winhl = "VertSplit:WinSeparatorZen,WinSeparator:WinSeparatorZen",
  disable_opt = { "buflisted", "modifiable" },
}

local window = { main = {}, pad = {} }

function window.main.create()
  local cursorpos = api.nvim_win_get_cursor(0)
  -- open current window as new tabpage, before current tabpage
  -- when we exit zen mode, we return to the previous tabpage
  vim.cmd("-tabe %")
  window.main.nr = api.nvim_get_current_win()
  window.main.buf = { nr = api.nvim_buf_get_number(0) }
  api.nvim_win_set_option(window.main.nr, "winhighlight", pad.winhl)
  api.nvim_win_set_cursor(window.main.nr, cursorpos)
  vim.cmd("normal! zz")
  opt(true)
end

function window.pad.create(side)
  vim.cmd(("%s %dvnew"):format(pad.cmd[side], pad.width))
  pad.buf[side] = api.nvim_buf_get_number(0)
  pad.win[side] = api.nvim_get_current_win()
  api.nvim_win_set_option(pad.win[side], "winhighlight", pad.winhl)
  opt(true, { win = true })

  for _, bufopt in ipairs(pad.disable_opt) do
    api.nvim_buf_set_option(pad.buf[side], bufopt, false)
  end

  pad.exist = true
  api.nvim_set_current_win(window.main.nr)
end

function window.pad.adjust(id)
  local delta = window.main.buf.textwidth - window.main.width
  api.nvim_win_set_width(id, math.floor((2 * pad.width - delta) / 2))
end

local function zen(enter)
  local columns = api.nvim_get_option("columns")
  local textwidth = api.nvim_buf_get_option(0, "textwidth")

  if enter then
    window.main.create()
    pad.width = math.floor(columns / 5)

    if columns < textwidth or pad.width <= api.nvim_get_option("winwidth") then
      pad.exist = false
      return
    end
    window.pad.create("left")
    window.pad.create("right")

    window.main.width = api.nvim_win_get_width(window.main.nr)
    window.main.buf.textwidth = api.nvim_buf_get_option(
      window.main.buf.nr,
      "textwidth"
    )

    -- main window must have a width at least equal to 'textwidth'
    if window.main.width >= window.main.buf.textwidth then
      return
    end
    window.pad.adjust(pad.win.left)
    window.pad.adjust(pad.win.right)
    return
  end

  local cursorpos = api.nvim_win_get_cursor(0)
  if pad.exist then
    for _, id in pairs(pad.buf) do
      api.nvim_buf_delete(id, { force = true })
    end
  end
  vim.cmd("tabclose")
  opt(false)
  api.nvim_win_set_cursor(0, cursorpos)
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
