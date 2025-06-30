local a = vim.api

local set = a.nvim_set_option_value
-- set("readonly", true, { buf = 0 })
set("statusline", " %f ", { scope = "local", win = 0 })

local map = a.nvim_buf_set_keymap
map(0, "n", "d", "<C-d>", { noremap = true })
map(0, "n", "u", "<C-u>", { noremap = true })
map(0, "n", "q", "<C-w>q", { noremap = true })
