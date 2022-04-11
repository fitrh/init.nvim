local set = vim.opt_local

set.colorcolumn = ""
set.signcolumn = "yes"

vim.keymap.set("n", "q", ":close<CR>", { buffer = true, silent = true })
