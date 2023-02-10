local a = vim.api

a.nvim_create_autocmd("UIEnter", {
  group = a.nvim_create_augroup("set_colorscheme", {}),
  callback = function()
    local default = "tokyonight"
    local colorschemes = {
      ["doom-one"] = "DoomOnePre",
      github = "GithubPre",
      gruvbox = "GruvboxPre",
      kanagawa = "KanagawaPre",
      material = "MaterialPre",
      ["rose-pine"] = "RosePinePre",
      tokyonight = "TokyoNightPre",
    }

    local NVIM_COLORSCHEME = os.getenv("NVIM_COLORSCHEME")
    local colorscheme = colorschemes[NVIM_COLORSCHEME]
    if not colorscheme then
      NVIM_COLORSCHEME = default
      colorscheme = colorschemes[NVIM_COLORSCHEME]
    end

    a.nvim_exec_autocmds("ColorSchemePre", {})
    a.nvim_exec_autocmds("User", { pattern = colorscheme })
    a.nvim_exec_autocmds("ColorScheme", { pattern = NVIM_COLORSCHEME })
  end,
})
