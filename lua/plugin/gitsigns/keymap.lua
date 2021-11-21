local M = {}

local hunk = {
  next = "Gitsigns next_hunk",
  prev = "Gitsigns prev_hunk",
  stage = "Gitsigns stage_hunk",
  stage_selected = "'<,'>Gitsigns stage_hunk",
  stage_buffer = "Gitsigns stage_buffer",
  reset = "Gitsigns reset_hunk",
  reset_buffer = "Gitsigns reset_buffer_index",
  reset_selected = "'<,'>Gitsigns reset_hunk",
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
  blame_win = "Gitsigns blame_line full=true",
}

function M.on_attach(bufnr)
  local keymap = require("lib.keymap")
  local on = keymap.on_press
  local lead = keymap.on_press_leader
  local opt = keymap.opt

  keymap.bind({
    on("]c", "n"):exec(hunk.next),
    on("[c", "n"):exec(hunk.prev),
    on("ghs", "n"):exec(hunk.stage),
    on("ghS", "n"):exec(hunk.stage_buffer),
    on("ghs", "v"):exec(hunk.stage_selected),
    on("ghu", "n"):exec(hunk.undo),
    on("ghU", "n"):exec(hunk.reset_buffer),
    on("ghr", "n"):exec(hunk.reset),
    on("ghr", "v"):exec(hunk.reset_selected),
    on("ghR", "n"):exec(hunk.reset_all),
    on("ghp", "n"):exec(hunk.preview),
    on("ih", "o"):exec(hunk.select),
    on("ih", "x"):exec(hunk.select),
    on("gbl", "n"):exec(toggle.blame_win),
    on("gt", "n"):exec(toggle.sign),
    on("gnm", "n"):exec(toggle.numhl),
    on("gll", "n"):exec(toggle.linehl),
    on("gwd", "n"):exec(toggle.word_diff),
    lead("gl", "n"):exec(toggle.blame),
  }, {
    bufnr = bufnr,
    options = opt():noremap(),
  })
end

return M
