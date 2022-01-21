local line = require("lualine")
local colors = require("plugin.themes.palette")
local lsp = require("plugin.lualine.component.lsp").setup({ fg = colors.blue2 })
local custom = {
  extension = require("plugin.lualine.extension"),
  component = require("plugin.lualine.component"),
}
local file = custom.component.file
local state = custom.component.state
local git = custom.component.git
local spacer = custom.component.spacer

local options = {
  component_separators = "",
  section_separators = "",
  disabled_filetypes = { "Outline" },
}

local extensions = { "quickfix" }
for _, extension in pairs(custom.extension) do
  table.insert(extensions, extension)
end

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
}

local sections = {
  lualine_a = {},
  lualine_b = {},
  lualine_c = {
    custom.component.mode,
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
  lualine_z = {},
}

line.setup({
  options = options,
  sections = sections,
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "%=", file.name },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  extensions = extensions,
})
