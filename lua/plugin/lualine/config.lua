local lualine = require("lualine")
local align = require("plugin.lualine.component.util.alignment")
local custom = {
  extension = require("plugin.lualine.extension"),
  component = require("plugin.lualine.component"),
}
local mode = custom.component.mode
local file = custom.component.file
local state = custom.component.state
local git = custom.component.git
local lsp = custom.component.lsp
local spacer = custom.component.spacer
local strip = custom.component.strip
local config = {}

config.options = {
  component_separators = "",
  section_separators = "",
  disabled_filetypes = { "Outline" },
}

config.extensions = { "quickfix" }
for _, extension in pairs(custom.extension) do
  table.insert(config.extensions, extension)
end

config.sections = {
  lualine_a = {},
  lualine_b = {},
  lualine_y = {},
  lualine_z = {},
}

config.sections.lualine_c = {
  strip(),
  align.left(mode),
  spacer(),
  align.left(state.readonly),
  align.left(file.icon),
  align.left(file.name),
  align.no(state.modified),
  { "diagnostics", sources = { "nvim_diagnostic" } },
}

config.sections.lualine_x = {
  lsp.progress,
  align.right(git.diff),
  git.branch,
  align.right(file.location),
  align.right(file.lines),
  strip("right"),
}

config.inactive_sections = {
  lualine_a = {},
  lualine_b = {},
  lualine_c = { "%=", file.name },
  lualine_x = {},
  lualine_y = {},
  lualine_z = {},
}

lualine.setup(config)
