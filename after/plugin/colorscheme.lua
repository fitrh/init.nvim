local group = vim.api.nvim_create_augroup("UseColorScheme", {})
vim.api.nvim_create_autocmd("VimEnter", {
  group = group,
  callback = function()
    local default = "tokyonight"
    local colorschemes = {
      ["doom-one"] = "doom-one",
      github = "github",
      gruvbox = "gruvbox",
      kanagawa = "kanagawa",
      material = "material",
      ["rose-pine"] = "rose-pine",
      tokyonight = "tokyonight",
    }

    local colorscheme = colorschemes[os.getenv("NVIM_COLORSCHEME")] or default
    vim.api.nvim_exec_autocmds("ColorSchemePre", {})
    vim.cmd.packadd(("colorscheme/%s"):format(colorscheme))
    require(("config.plugin.colorscheme.%s.setup"):format(colorscheme))
    vim.api.nvim_exec_autocmds(("ColorScheme %s"):format(colorscheme), {})
  end,
})
