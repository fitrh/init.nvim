local a = vim.api
local group = a.nvim_create_augroup("adwaita_colorscheme", {})

a.nvim_create_autocmd("ColorScheme", {
  group = group,
  pattern = "adwaita",
  callback = function()
    local module = "config.plugin.colorscheme.adwaita.setup"
    package.loaded[module] = nil
    require(module)
  end,
})

a.nvim_create_autocmd("User", {
  group = group,
  pattern = "AdwaitaPre",
  callback = function()
    vim.cmd.colorscheme("adwaita")
  end,
})
