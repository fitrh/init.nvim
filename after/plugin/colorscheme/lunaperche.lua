local a = vim.api
local group = a.nvim_create_augroup("lunaperche_colorscheme", {})

a.nvim_create_autocmd("ColorScheme", {
  group = group,
  pattern = "lunaperche",
  callback = function()
    local module = "config.colorscheme.lunaperche"
    package.loaded[module] = nil
    require(module)
  end,
})

a.nvim_create_autocmd("User", {
  group = group,
  pattern = "LunaPerchePre",
  callback = function()
    vim.cmd.colorscheme("lunaperche")
  end,
})
