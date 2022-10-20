local set = vim.opt_local
set.shiftwidth = 4
set.tabstop = 4
set.textwidth = 79

local telescope = {}
telescope.ok, telescope.module = pcall(require, "telescope.builtin")
if telescope.ok then
  vim.keymap.set("n", "gb", telescope.module.buffers, { buffer = 0 })
end
