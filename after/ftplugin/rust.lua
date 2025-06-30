local a = vim.api
local setl = a.nvim_set_option_value
local localbuf = { buf = 0 }

setl("expandtab", true, localbuf)
setl("tabstop", 4, localbuf)
setl("textwidth", 100, localbuf)
