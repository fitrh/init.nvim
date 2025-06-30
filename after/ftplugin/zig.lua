local a = vim.api
local set = a.nvim_set_option_value
local localbuf = { buf = 0 }

set("expandtab", true, localbuf)
set("tabstop", 4, localbuf)
set("textwidth", 100, localbuf)
