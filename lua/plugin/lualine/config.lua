local lualine = require("lualine")
local util = require("plugin.lualine.component.util")
local align = util.align
local mod = util.mod
local custom = {
  extension = require("plugin.lualine.extension"),
  component = require("plugin.lualine.component"),
}
local mode = custom.component.mode
local file = custom.component.file
local state = custom.component.state
local git = custom.component.git
local diagnostic = custom.component.diagnostic
local spacer = custom.component.spacer
local strip = {
  L = custom.component.strip("left"),
  R = custom.component.strip("right"),
}
local icon = {
  active = mod(file.icon, { cond = util.condition.not_modified }),
  inactive = mod(file.icon, { colored = false, padding = 0 }),
}
local config = {}

config.options = {
  theme = require("plugin.themes.lualine"),
  component_separators = "",
  section_separators = "",
  disabled_filetypes = { "Outline" },
  globalstatus = true,
}

config.extensions = { "quickfix" }
for _, extension in pairs(custom.extension) do
  table.insert(config.extensions, extension)
end

config.sections = {}
config.inactive_sections = {}
for _, v in ipairs({ "a", "b", "c", "x", "y", "z" }) do
  local section = ("lualine_%s"):format(v)
  config.sections[section] = {}
  config.inactive_sections[section] = {}
end

config.sections.lualine_a = { strip.L, align.left(mode) }
config.sections.lualine_c = {
  spacer(),
  align.left(state.readonly),
  align.left(icon.active),
  align.left(state.modified),
  align.left(file.name),
  align.left(diagnostic.buffer),
}
config.sections.lualine_x = {
  align.right(git.diff),
  align.right(git.branch),
  mod(spacer(), { cond = util.condition.not_empty_buf }),
  align.right(file.location),
}
config.sections.lualine_z = { align.right(file.lines), strip.R }

config.inactive_sections.lualine_c = { "%=", icon.inactive, file.name }

lualine.setup(config)
