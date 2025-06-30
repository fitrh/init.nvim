local set = vim.api.nvim_set_option_value
local localbuf = { buf = 0 }

-- set("conceallevel", 0, { scope = "local", win = 0 })
set("expandtab", true, localbuf)
set("tabstop", 2, localbuf)
