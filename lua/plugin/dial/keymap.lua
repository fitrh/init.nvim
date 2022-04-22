local map = vim.keymap.set

map({ "n" }, "<C-a>", "<Plug>(dial-increment)", { silent = true })
map({ "n" }, "<C-x>", "<Plug>(dial-decrement)", { silent = true })
map({ "v" }, "<C-a>", "<Plug>(dial-increment)", { silent = true })
map({ "v" }, "<C-x>", "<Plug>(dial-decrement)", { silent = true })
map({ "v" }, "g<C-a>", "g<Plug>(dial-increment)", { silent = true })
map({ "v" }, "g<C-x>", "g<Plug>(dial-decrement)", { silent = true })
