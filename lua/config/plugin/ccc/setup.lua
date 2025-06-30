require("ccc").setup({
  disable_default_mappings = true,
})

vim.api.nvim_set_keymap("n", "<Leader>cc", "<Cmd>CccHighlighterToggle<CR>", {
  silent = true,
  noremap = true,
})
