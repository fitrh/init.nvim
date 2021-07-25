local M = {}

local hunk = {
  nex = "Gitsigns next_hunk",
  prev = "Gitsigns prev_hunk",
  stage = "Gitsigns stage_hunk",
  stages = 'require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})',
  reset = "Gitsigns reset_hunk",
  resetl = 'require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})',
  reset_all = "Gitsigns reset_buffer",
  undo = "Gitsigns undo_stage_hunk",
  preview = "Gitsigns preview_hunk",
  select = "Gitsigns select_hunk",
}

local toggle = {
  sign = "Gitsigns toggle_signs",
  numhl = "Gitsigns toggle_numhl",
  linehl = "Gitsigns toggle_linehl",
  word_diff = "Gitsigns toggle_word_diff",
  blame = "Gitsigns toggle_current_line_blame",
  blame_win = "Gitsigns blame_line true",
}

function M.on_attach(nr)
  local keymap = require("util.keymap")
  local on = keymap.on_press
  local lead = keymap.on_press_leader
  local opt = keymap.opt

  keymap.bind({
    on("]c", "n"):buf(nr):exec(hunk.nex):with(opt():noremap()),
    on("[c", "n"):buf(nr):exec(hunk.prev):with(opt():noremap()),
    on("ghs", "n"):buf(nr):exec(hunk.stage):with(opt():noremap()),
    on("ghs", "v"):buf(nr):lua(hunk.stages):with(opt():noremap()),
    on("ghu", "n"):buf(nr):exec(hunk.undo):with(opt():noremap()),
    on("ghr", "n"):buf(nr):exec(hunk.reset):with(opt():noremap()),
    on("ghr", "v"):buf(nr):lua(hunk.resetl):with(opt():noremap()),
    on("ghR", "n"):buf(nr):exec(hunk.reset_all):with(opt():noremap()),
    on("ghp", "n"):buf(nr):exec(hunk.preview):with(opt():noremap()),
    on("ih", "o"):buf(nr):exec(hunk.select):with(opt():noremap()),
    on("ih", "x"):buf(nr):exec(hunk.select):with(opt():noremap()),
    on("gbl", "n"):buf(nr):exec(toggle.blame_win):with(opt():noremap()),
    on("gt", "n"):buf(nr):exec(toggle.sign):with(opt():noremap()),
    on("gnm", "n"):buf(nr):exec(toggle.numhl):with(opt():noremap()),
    on("gll", "n"):buf(nr):exec(toggle.linehl):with(opt():noremap()),
    on("gwd", "n"):buf(nr):exec(toggle.word_diff):with(opt():noremap()),
    lead("gl", "n"):buf(nr):exec(toggle.blame):with(opt():noremap()),
  })
end

return M
