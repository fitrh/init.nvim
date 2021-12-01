local keymap = require("lib.keymap")
local on = keymap.on_press
local lead = keymap.on_press_leader
local opt = keymap.opt

keymap.bind({
  on("[b", "n"):exec("Telescope buffers"),
  on("[p"):exec("Telescope find_files"),
  on("[f"):exec("Telescope live_grep"),
  on("[ld", "n"):exec("Telescope lsp_document_diagnostics"),
  on("[lD", "n"):exec("Telescope lsp_workspace_diagnostics"),
  lead("e"):exec("Telescope file_browser"),
  lead("ft"):exec("Telescope filetypes"),
  lead("lo"):exec("Telescope treesitter"),
  lead("gf", "n"):exec("Telescope git_files"),
  lead("gc", "n"):exec("Telescope git_commits"),
  lead("gb", "n"):exec("Telescope git_branches"),
  lead("gs", "n"):exec("Telescope git_status"),
  lead("m", "n"):exec("Telescope keymaps"),
}, {
  options = opt():noremap(),
})
