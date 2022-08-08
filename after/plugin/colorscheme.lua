local group = vim.api.nvim_create_augroup("UseColorScheme", {})
vim.api.nvim_create_autocmd("VimEnter", {
  group = group,
  callback = function()
    local NVIM_COLORSCHEME = os.getenv("NVIM_COLORSCHEME")
    local colorscheme = "tokyonight"

    if NVIM_COLORSCHEME and NVIM_COLORSCHEME ~= "" then
      colorscheme = NVIM_COLORSCHEME
    end

    vim.cmd.packadd(("colorscheme/%s"):format(colorscheme))
    require(("config.plugin.colorscheme.%s.setup"):format(colorscheme))
    vim.api.nvim_exec_autocmds(("ColorScheme %s"):format(colorscheme), {})
  end,
})
