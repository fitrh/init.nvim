local keymap = require("sugar.keymap")
local map, leader, n = keymap.map, keymap.modifier.leader, keymap.mode.normal

local b = require("telescope.builtin")
local t = require("telescope.themes")

keymap.bind({
  n(map("[]", b.buffers)),
  n(map("[p", b.find_files)),
  n(map("[f", b.live_grep)),
  n(map(leader("e"), b.file_browser)),
  n(map(leader("ft"), b.filetypes)),
  n(map(leader("lo"), b.treesitter)),
  n(map(leader("gf"), b.git_files)),
  n(map(leader("gc"), b.git_commits)),
  n(map(leader("gb"), b.git_branches)),
  n(map("gS", b.git_status)),
  n(map(leader("m"), b.keymaps)),
  n(map("[ld", function()
    b.diagnostics(t.get_dropdown({ bufnr = 0 }))
  end)),
  n(map("[lD", b.diagnostics)),
})
