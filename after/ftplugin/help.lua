local set = vim.opt_local

set.colorcolumn = ""
set.signcolumn = "no"

vim.keymap.set("n", "q", "<C-w>q", { buffer = true })
