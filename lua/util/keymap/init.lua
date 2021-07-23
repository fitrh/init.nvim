local M = {}

function M.opt()
  local opt = require("util.keymap.option")
  return opt:new()
end

function M.on_press(key, in_mode)
  local map = require("util.keymap.map")
  return map:new():on_press(key, in_mode)
end

function M.on_press_leader(key, in_mode)
  local map = require("util.keymap.map")
  local _key = ("<Leader>%s"):format(key)
  return map:new():on_press(_key, in_mode)
end

function M.termcode(str)
  local termcode = vim.api.nvim_replace_termcodes
  return termcode(str, true, true, true)
end

function M.bind(maps)
  local keymap = vim.api.nvim_set_keymap
  local buf_keymap = vim.api.nvim_buf_set_keymap
  for _, map in ipairs(maps) do
    if map._bufnr then
      buf_keymap(map._bufnr, map._mode, map._key, map._command, map._options)
    else
      keymap(map._mode, map._key, map._command, map._options)
    end
  end
end

return M
