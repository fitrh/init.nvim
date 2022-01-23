local line = require("lualine")
local colors = require("plugin.themes.palette")
local align = require("plugin.lualine.component.util.alignment")
local lsp = require("plugin.lualine.component.lsp").setup({ fg = colors.blue2 })
local custom = {
  extension = require("plugin.lualine.extension"),
  component = require("plugin.lualine.component"),
}
local file = custom.component.file
local state = custom.component.state
local git = custom.component.git
local spacer = custom.component.spacer
local strip = custom.component.strip

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
    strip(),
    align.left(custom.component.mode),
    spacer(),
    align.left(state.readonly),
    align.left(file.icon),
    align.left(file.name),
    align.no(state.modified),
    diagnostics,
  },
  lualine_x = {
    align.right(git.diff),
    git.branch,
    align.no(lsp.status),
    align.right(file.location),
    align.right(file.lines),
    strip("right"),
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
