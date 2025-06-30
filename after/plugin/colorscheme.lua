local a = vim.api

a.nvim_create_autocmd("UIEnter", {
  group = a.nvim_create_augroup("set_colorscheme", {}),
  callback = function()
    local env = os.getenv

    local background = env("NVIM_BACKGROUND")
    -- seems unnecessary since nvim automatically set 'background' option
    -- based on terminal background color
    --
    -- Nope, the built-in mechanism to set 'background' is too slow, we can see
    -- a flicker on light terminal background
    if not background then
      local hour = tonumber(os.date("%H"))
      if hour >= 7 and hour < 18 then
        a.nvim_set_option_value("background", "light", {})
        vim.uv.os_setenv("NVIM_BACKGROUND", "light")
      else
        a.nvim_set_option_value("background", "dark", {})
        vim.uv.os_setenv("NVIM_BACKGROUND", "dark")
      end
    elseif background == "light" or background == "dark" then
      a.nvim_set_option_value("background", background, {})
    end

    local colorscheme = env("NVIM_COLORSCHEME")
    if not colorscheme or not a.nvim_get_option_value("termguicolors", {}) then
      a.nvim_exec_autocmds("ColorScheme", { pattern = "default" })
      a.nvim_set_var("colors_name", "default")
      return true
    end

    local colorschemes = {
      adwaita = "AdwaitaPre",
      ["doom-one"] = "DoomOnePre",
      doom = "DoomOnePre",
      github = "GithubPre",
      gruvbox = "GruvboxPre",
      iceberg = "IcebergPre",
      kanagawa = "KanagawaPre",
      lunaperche = "LunaPerchePre",
      material = "MaterialPre",
      nord = "NordPre",
      oxocarbon = "OxocarbonPre",
      retrobox = "RetroboxPre",
      ["rose-pine"] = "RosePinePre",
      tokyonight = "TokyoNightPre",
      quiet = "QuietPre",
    }
    local color_event = colorschemes[colorscheme]
    if not color_event then
      a.nvim_exec_autocmds("ColorScheme", { pattern = "default" })
      -- NOTE: `g:colors_name` is required to trigger `ColorScheme default`
      a.nvim_set_var("colors_name", "default")
      return true
    end

    a.nvim_exec_autocmds("ColorSchemePre", {})
    a.nvim_exec_autocmds("User", { pattern = color_event })
    -- FIXME The following command is required if `:colorscheme` is not invoked
    -- Set colorscheme using `:colorscheme` causes the `ColorScheme` event triggered twice
    -- move it to `User {Scheme}Pre` callback
    a.nvim_exec_autocmds("ColorScheme", { pattern = colorscheme })
  end,
  once = true,
})
