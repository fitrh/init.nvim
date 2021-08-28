local M = {}

function M.opt()
  local opt = require("util.keymap.option")
  return opt:new()
end

function M.on_press(key, in_mode, bufnr)
  local map = require("util.keymap.map")
  if type(in_mode) == "number" then
    bufnr = in_mode
    in_mode = nil
  end
  return map:new():on_press(key, in_mode, bufnr)
end

function M.on_press_leader(key, in_mode, bufnr)
  local _key = ("<Leader>%s"):format(key)
  return M.on_press(_key, in_mode, bufnr)
end

function M.termcode(str)
  local termcode = vim.api.nvim_replace_termcodes
  return termcode(str, true, true, true)
end

function M.bind(maps, bufnr)
  local keymap = vim.api.nvim_set_keymap
  local buf_keymap = vim.api.nvim_buf_set_keymap
  for _, map in ipairs(maps) do
    if map._bufnr or bufnr then
      local _bufnr = map._bufnr or bufnr
      buf_keymap(_bufnr, map._mode, map._key, map._command, map._options)
    else
      keymap(map._mode, map._key, map._command, map._options)
    end
  end
end

return M
