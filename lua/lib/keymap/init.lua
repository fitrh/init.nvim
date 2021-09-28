local M = {}

function M.opt()
  local opt = require("lib.keymap.option")
  return opt:new()
end

function M.on_press(key, mode, bufnr)
  local map = require("lib.keymap.map")
  if type(mode) == "number" then
    bufnr = mode
    mode = nil
  end
  return map:new():on_press(key, mode, bufnr)
end

function M.on_press_leader(key, mode, bufnr)
  local _key = ("<Leader>%s"):format(key)
  return M.on_press(_key, mode, bufnr)
end

function M.termcode(str)
  local termcode = vim.api.nvim_replace_termcodes
  return termcode(str, true, true, true)
end

function M.bind(maps, args)
  local opts = args or {}
  local keymap = vim.api.nvim_set_keymap
  local buf_keymap = vim.api.nvim_buf_set_keymap
  for _, map in pairs(maps) do
    local opt = nil
    if opts.options then
      opt = opts.options.get and opts.options:get() or opts.options
    end
    opt = map._options or opt
    opt = type(opt) == "table" and opt or {}
    if map._bufnr or opts.bufnr then
      local _bufnr = map._bufnr or opts.bufnr
      _bufnr = type(_bufnr) == "number" and _bufnr or 0
      buf_keymap(_bufnr, map._mode, map._key, map._command, opt)
    else
      keymap(map._mode, map._key, map._command, opt)
    end
  end
end

return M
