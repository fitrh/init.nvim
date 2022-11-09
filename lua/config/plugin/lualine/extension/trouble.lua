local hl = require("sugar.highlight")
local color = { fg = hl.fg("DiagnosticWarn")(), gui = "BOLD" }
local mod = require("config.plugin.lualine.component.util.mod")
local component = require("config.plugin.lualine.component")
local diagnostic = component.diagnostic.workspace

local title = {
  function()
    return "裂Troubles"
  end,
  color = color,
}

local components = {
  active = { title, diagnostic },
  inactive = {
    mod(title, { color = {} }),
    mod(diagnostic, { colored = false, update_in_insert = true }),
  },
}

local M = {}

M.filetypes = { "Trouble" }

M.sections = { lualine_c = components.active }

M.inactive_sections = { lualine_c = components.inactive }

return M
