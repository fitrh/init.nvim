local line = require("lualine")
local colors = require("plugin.themes.palette")
local lsp = require("plugin.lualine.component.lsp").setup({ fg = colors.blue2 })
local component = require("plugin.lualine.component")
local file = component.file
local state = component.state
local git = component.git
local spacer = component.spacer

local options = {
  component_separators = "",
  section_separators = "",
  disabled_filetypes = { "Outline", "help" },
}

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
}

local sections = {
  lualine_a = { spacer() },
  lualine_b = {},
  lualine_c = {
    component.mode,
    spacer(),
    state.readonly,
    file.icon,
    file.name,
    state.modified,
    diagnostics,
  },
  lualine_x = {
    git.diff,
    git.branch,
    lsp.status,
    file.location,
    file.lines,
    spacer(),
  },
  lualine_y = {},
  lualine_z = { spacer() },
}

line.setup({
  options = options,
  sections = sections,
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
})
