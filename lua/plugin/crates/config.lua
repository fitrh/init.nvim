require("crates").setup({
  text = {
    loading = "   Loading  ",
    version = "  ﰖ %s  ",
    prerelease = "  裂%s  ",
    yanked = "  戀%s  ",
    nomatch = "  𥉉No match  ",
    update = "  療%s  ",
    error = "   Error fetching crate  ",
  },
  highlight = {
    loading = "DiagnosticVirtualTextHint",
    version = "DiagnosticVirtualTextInfo",
    prerelease = "DiagnosticVirtualTextWarn",
    yanked = "DiagnosticVirtualTextError",
    nomatch = "DiagnosticVirtualTextWarn",
    update = "DiagnosticHint",
    error = "DiagnosticVirtualTextError",
  },
  popup = {
    autofocus = true, -- focus the versions popup when opening it
    border = "rounded", -- same as nvim_open_win config.border
    version_date = true, -- display when a version was released
    max_height = 10,
    min_width = 20,
    text = {
      title = " 📦 %s ",
      version = "   %s ",
      prerelease = " 裂%s ",
      yanked = " 戀%s ",
      feature = "   %s ",
      date = " %s ",
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

require("plugin.crates.command")
require("plugin.crates.keymap")
