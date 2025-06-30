local a = vim.api
local group = a.nvim_create_augroup("iceberg_colorscheme_override", {})

a.nvim_create_autocmd("ColorScheme", {
  group = group,
  pattern = "iceberg",
  callback = function()
    local module = "config.plugin.colorscheme.iceberg.setup"
    package.loaded[module] = nil
    require(module)
  end,
})

-- a.nvim_create_autocmd("OptionSet", {
--   group = group,
--   pattern = "background",
--   callback = function()
--     local module = "config.plugin.colorscheme.iceberg.setup"
--     if package.loaded[module] then
--       a.nvim_exec_autocmds("User", {
--         group = group,
--         pattern = "IcebergReload",
--       })
--     end
--   end,
-- })

a.nvim_create_autocmd("User", {
  group = group,
  pattern = "IcebergPre",
  callback = function()
    vim.cmd.highlight("clear")
    -- vim.cmd.colorscheme("vim")
    vim.cmd.colorscheme("iceberg")
  end,
})
