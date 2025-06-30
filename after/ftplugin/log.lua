local a = vim.api

a.nvim_set_option_value("readonly", true, { buf = 0 })

local map = a.nvim_buf_set_keymap
map(0, "n", "d", "<C-d>", { noremap = true })
map(0, "n", "D", "<C-u>", { noremap = true })
map(0, "n", "u", "<C-u>", { noremap = true })
