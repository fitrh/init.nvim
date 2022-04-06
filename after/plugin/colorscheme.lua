local colorscheme = os.getenv("NVIM_COLORSCHEME") or "tokyonight"
local group = vim.api.nvim_create_augroup("UseColorScheme", {})
vim.api.nvim_create_autocmd("VimEnter", {
  group = group,
  callback = function()
    vim.cmd(("packadd colorscheme/%s"):format(colorscheme))
    require(("plugin.colorscheme.%s.config"):format(colorscheme))
    vim.api.nvim_exec_autocmds(("ColorScheme %s"):format(colorscheme), {})
  end,
})
