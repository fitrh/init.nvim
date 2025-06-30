local a = vim.api
local group = a.nvim_create_augroup("retrobox_colorscheme_override", {})

a.nvim_create_autocmd("ColorScheme", {
  group = group,
  pattern = "retrobox",
  callback = function()
    local module = "config.colorscheme.retrobox"
    package.loaded[module] = nil
    require(module)
  end,
})

a.nvim_create_autocmd("User", {
  group = group,
  pattern = "RetroboxPre",
  callback = function()
    vim.cmd.colorscheme("retrobox")
  end,
})
