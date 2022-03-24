local M = {}

local hunk = {
  next = "&diff ? ']c' : '<Cmd>Gitsigns next_hunk<CR>'",
  prev = "&diff ? '[c' : '<Cmd>Gitsigns prev_hunk<CR>'",
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
  deleted = "Gitsigns toggle_deleted",
  word_diff = "Gitsigns toggle_word_diff",
  blame = "Gitsigns toggle_current_line_blame",
  blame_win = "Gitsigns blame_line full=true",
}

function M.attach(bufnr)
  local keymap = require("lib.keymap")
  local on = keymap.on_press
  local opt = keymap.opt

  keymap.bind({
    on("]c", "n"):send(hunk.next):with(opt():expr()),
    on("[c", "n"):send(hunk.prev):with(opt():expr()),
    on("gss", "n"):exec(hunk.stage),
    on("gsS", "n"):exec(hunk.stage_buffer),
    on("gss", "v"):exec(hunk.stage_selected),
    on("gsu", "n"):exec(hunk.undo),
    on("gsU", "n"):exec(hunk.reset_buffer),
    on("gsr", "n"):exec(hunk.reset),
    on("gsr", "v"):exec(hunk.reset_selected),
    on("gsR", "n"):exec(hunk.reset_all),
    on("gsp", "n"):exec(hunk.preview),
    on("ih", "o"):exec(hunk.select),
    on("ih", "x"):exec(hunk.select),
    on("gsB", "n"):exec("Blame"),
    on("gsb", "n"):exec(toggle.blame_win),
    on("gst", "n"):exec(toggle.sign),
    on("gsn", "n"):exec(toggle.numhl),
    on("gsL", "n"):exec(toggle.linehl),
    on("gsd", "n"):exec(toggle.deleted),
    on("gsw", "n"):exec(toggle.word_diff),
    on("gsl", "n"):exec(toggle.blame),
  }, {
    bufnr = bufnr,
    options = opt():noremap(),
  })
end

return M
