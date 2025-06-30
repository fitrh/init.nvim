local a = vim.api
local set = a.nvim_set_option_value
local localbuf = { buf = 0 }
local localwin = { win = 0 }

set("colorcolumn", "81,121", localwin)
set("expandtab", true, localbuf)
set("tabstop", 4, localbuf)
