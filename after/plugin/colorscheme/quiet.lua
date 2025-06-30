local a = vim.api
local group = a.nvim_create_augroup("quiet_colorscheme_override", {})

a.nvim_create_autocmd("ColorScheme", {
  group = group,
  pattern = "quiet",
  callback = function()
    local module = "config.colorscheme.quiet"
    package.loaded[module] = nil
    require(module)
  end,
})

a.nvim_create_autocmd("User", {
  group = group,
  pattern = "QuietPre",
  callback = function()
    vim.cmd.colorscheme("quiet")
  end,
})
