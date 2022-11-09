local lualine = require("lualine")
local util = require("config.plugin.lualine.component.util")
local align = util.align
local mod = util.mod
local custom = {
  extension = require("config.plugin.lualine.extension"),
  component = require("config.plugin.lualine.component"),
}
local mode = custom.component.mode
local file = custom.component.file
local state = custom.component.state
local git = custom.component.git
local diagnostic = custom.component.diagnostic
local spacer = custom.component.spacer
local icon = {
  active = mod(file.icon, { cond = util.condition.not_modified }),
  inactive = mod(file.icon, { colored = false, padding = 0 }),
}
local config = {}

config.options = {
  theme = require("config.plugin.lualine.theme"),
  component_separators = "",
  section_separators = "",
  disabled_filetypes = { "Outline" },
  globalstatus = true,
  refresh = { statusline = vim.api.nvim_get_option("updatetime") },
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

config.sections.lualine_a = { mode }
config.sections.lualine_c = {
  spacer(),
  align.left(file.path({ trunc = true })),
  align.left(state.readonly),
  align.left(icon.active),
  align.left(state.modified),
  align.left(file.name),
  align.left(diagnostic.buffer),
}
config.sections.lualine_x = {
  align.right(git.diff),
  git.branch,
  align.right(file.location),
  file.lines,
}

config.inactive_sections.lualine_c = { "%=", icon.inactive, file.name }

lualine.setup(config)
