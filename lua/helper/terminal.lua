---@class TerminalID
---@field term number|nil
---@field buf number|nil
---@field win number|nil

---@class TerminalState
---@field id TerminalID
---@field open boolean

---@alias TerminalSplitPos
---| '"aboveleft"'
---| '"belowright"'
---| '"topleft"'
---| '"botright"'

---@class TerminalWindow
---@field size integer
---@field split TerminalSplitPos

local a = vim.api

---@type TerminalState
local STATE = {
  id = { term = nil, buf = nil, win = nil },
  open = false,
}

---@type TerminalWindow
local window = { size = 9, split = "botright" }

---@param args number|string
---@param size integer
---@param modifier TerminalSplitPos
local function split(args, size, modifier)
  a.nvim_cmd({
    cmd = "split",
    args = { args },
    range = { size },
    mods = { split = modifier },
  }, { output = false })
end

local Terminal = {}

local opt = { set = a.nvim_set_option_value, get = a.nvim_get_option_value }
local current_buf = a.nvim_get_current_buf
local current_win = a.nvim_get_current_win

---@param size? integer
---@param position? TerminalSplitPos
function Terminal.toggle(size, position)
  size = size or window.size
  position = position or window.split

  if STATE.open then
    -- close if current window is the terminal
    if opt.get("buftype", { buf = current_buf() }) == "terminal" then
      -- TODO: fix cursorline disappear when using STATE.id.win instead of 0
      a.nvim_win_close(0, false)
      STATE.open = false
      return true
    end

    -- focus to terminal window
    a.nvim_set_current_win(STATE.id.win)
    return
  end

  -- open existing terminal buffer
  if STATE.id.term and not STATE.open then
    split(STATE.id.term, size, position)
    STATE.id.win = current_win()
    STATE.open = true
    return
  end

  split("term://$SHELL", size, position)
  STATE.id.term = vim.fn.expand("%:p")
  STATE.id.buf = current_buf()
  STATE.id.win = current_win()
  STATE.open = true

  a.nvim_create_autocmd({ "BufDelete", "BufWipeout", "TermClose" }, {
    buffer = STATE.id.buf,
    callback = function()
      STATE.open = false
      STATE.id = { term = nil, buf = nil, win = nil }
    end,
  })
end

return Terminal
