local api = vim.api

local state = {
  zen = false,
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
  buf = { left = nil, right = nil },
  win = { left = nil, right = nil },
  cmd = { left = "leftabove", right = "rightbelow" },
  width = 0,
  winhl = "VertSplit:WinSeparatorZen,WinSeparator:WinSeparatorZen",
  disable_opt = { "buflisted", "modifiable" },
}

local function zen(enter)
  local columns = api.nvim_get_option("columns")
  local textwidth = api.nvim_buf_get_option(0, "textwidth")

  if enter then
    local cursorpos = api.nvim_win_get_cursor(0)
    -- open current window as new tabpage, before current tabpage
    -- when we exit zen mode, we return to the previous tabpage
    vim.cmd("-tabe %")
    local main = {
      win = { nr = api.nvim_get_current_win() },
      buf = { nr = api.nvim_buf_get_number(0) },
    }
    api.nvim_win_set_option(main.win.nr, "winhighlight", pad.winhl)
    api.nvim_win_set_cursor(main.win.nr, cursorpos)
    vim.cmd("normal! zz")
    pad.width = math.floor(columns / 5)
    opt(enter)

    if columns > textwidth then
      -- create left-right padding window
      for side, cmd in pairs(pad.cmd) do
        vim.cmd(("%s %dvnew"):format(cmd, pad.width))
        pad.buf[side] = api.nvim_buf_get_number(0)
        pad.win[side] = api.nvim_get_current_win()
        api.nvim_win_set_option(pad.win[side], "winhighlight", pad.winhl)
        opt(enter, { win = true })

        for _, bufopt in ipairs(pad.disable_opt) do
          api.nvim_buf_set_option(pad.buf[side], bufopt, false)
        end

        api.nvim_set_current_win(main.win.nr)
      end

      main.win.width = api.nvim_win_get_width(main.win.nr)
      main.buf.textwidth = api.nvim_buf_get_option(main.buf.nr, "textwidth")
      -- main window must have a width at least equal to 'textwidth'
      if main.win.width < main.buf.textwidth then
        local delta = main.buf.textwidth - main.win.width
        pad.width = math.floor((2 * pad.width - delta) / 2)
        for _, id in pairs(pad.win) do
          api.nvim_win_set_width(id, pad.width)
        end
      end
    end
  else
    local cursorpos = api.nvim_win_get_cursor(0)
    if (columns > textwidth) and pad.buf.left and pad.buf.right then
      for _, id in pairs(pad.buf) do
        api.nvim_buf_delete(id, { force = true })
      end
    end
    vim.cmd("tabclose")
    opt(false)
    api.nvim_win_set_cursor(0, cursorpos)
  end
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
end

return Zen
