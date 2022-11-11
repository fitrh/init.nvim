local keymap = require("sugar.keymap")
local map = keymap.map
local hop = require("hop")
local dir = require("hop.hint").HintDirection
local opts = {
  AC = { direction = dir.AFTER_CURSOR },
  BC = { direction = dir.BEFORE_CURSOR },
  AC_LINE = { direction = dir.AFTER_CURSOR, current_line_only = true },
  BC_LINE = { direction = dir.BEFORE_CURSOR, current_line_only = true },
}

keymap.bind({
  map("f/", hop.hint_patterns),
  map("F/", function()
    hop.hint_patterns({ multi_windows = true })
  end),
  map("ff", hop.hint_words),
  map("fw", function()
    hop.hint_words(opts.AC_LINE)
  end),
  map("fb", function()
    hop.hint_words(opts.BC_LINE)
  end),
  map("fj", function()
    hop.hint_char2(opts.AC)
  end),
  map("fk", function()
    hop.hint_char2(opts.BC)
  end),
  map("fl", function()
    hop.hint_char2(opts.AC_LINE)
  end),
  map("fh", function()
    hop.hint_char2(opts.BC_LINE)
  end),
  map("Fj", function()
    hop.hint_words(opts.AC)
  end),
  map("Fk", function()
    hop.hint_words(opts.BC)
  end),
  map("Fl", function()
    hop.hint_words(opts.AC_LINE)
  end),
  map("Fh", function()
    hop.hint_words(opts.BC_LINE)
  end),
})
