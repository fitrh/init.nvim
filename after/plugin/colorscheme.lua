local a = vim.api

a.nvim_create_autocmd("UIEnter", {
  group = a.nvim_create_augroup("set_colorscheme", {}),
  callback = function()
    local env = os.getenv

    local background = env("NVIM_BACKGROUND")
    if background and (background == "light" or background == "dark") then
      a.nvim_set_option_value("background", background, {})
    end

    local colorscheme = env("NVIM_COLORSCHEME")
    if not colorscheme or not a.nvim_get_option_value("termguicolors", {}) then
      a.nvim_exec_autocmds("ColorScheme", { pattern = "default" })
      return true
    end

    local colorschemes = {
      ["doom-one"] = "DoomOnePre",
      github = "GithubPre",
      gruvbox = "GruvboxPre",
      kanagawa = "KanagawaPre",
      material = "MaterialPre",
      ["rose-pine"] = "RosePinePre",
      tokyonight = "TokyoNightPre",
    }
    local color_event = colorschemes[colorscheme]
    if not color_event then
      a.nvim_exec_autocmds("ColorScheme", { pattern = "default" })
      return true
    end

    a.nvim_exec_autocmds("ColorSchemePre", {})
    a.nvim_exec_autocmds("User", { pattern = color_event })
    a.nvim_exec_autocmds("ColorScheme", { pattern = colorscheme })
  end,
  once = true,
})
