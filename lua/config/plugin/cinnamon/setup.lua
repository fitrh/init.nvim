require("cinnamon").setup({
  extra_keymaps = true,
  extended_keymaps = true,
  override_keymaps = true,
  centered = false,
  scroll_limit = vim.api.nvim_get_option("lines") * 2,
})

for _, k in ipairs({ "Up", "Down", "Left", "Right", "PageUp", "PageDown" }) do
  for _, m in ipairs({ "", "i", "c", "l", "!", "t" }) do
    vim.api.nvim_set_keymap(m, ("<%s>"):format(k), "", {})
  end
end
