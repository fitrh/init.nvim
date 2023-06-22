require("crates").setup({
  text = {
    loading = "  Loading ",
    version = " ﰖ %s ",
    prerelease = " 裂%s ",
    yanked = " 戀%s ",
    nomatch = " 𥉉No match ",
    upgrade = " 療%s ",
    error = "  Error fetching crate ",
  },
  highlight = {
    loading = "DiagnosticVirtualTextHint",
    nomatch = "DiagnosticVirtualTextWarn",
    upgrade = "DiagnosticHint",
  },
  popup = {
    autofocus = true, -- focus the versions popup when opening it
    border = "solid", -- same as nvim_open_win config.border
    show_version_date = true, -- display when a version was released
    max_height = 10,
    min_width = 20,
    text = {
      title = " 📦 %s ",
      pill_left = "",
      pill_right = "",
      version = "   %s ",
      prerelease = " 裂%s ",
      yanked = " 戀%s ",
      feature = "   %s ",
      version_date = " %s ",
    },
    highlight = {
      title = "Title",
      version = "None",
      prerelease = "DiagnosticWarn",
      yanked = "DiagnosticError",
      feature = "DiagnosticHint",
    },
  },
})
