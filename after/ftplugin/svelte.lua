local a = vim.api
local set = a.nvim_set_option_value
local localbuf = { buf = 0 }

set("commentstring", "<!-- %s -->", localbuf)
set("tabstop", 2, localbuf)
