local hl = require("sugar.highlight")
local color = { fg = hl.fg("DiagnosticWarn"), gui = "BOLD" }
local mod = require("plugin.lualine.component.util.mod")
local component = require("plugin.lualine.component")
local diagnostic = component.diagnostic.workspace
local strip = mod(component.strip(), { color = color })

local title = {
  function()
    return "裂Troubles"
  end,
  color = color,
  padding = { left = 0, right = 1 },
}

local components = {
  active = { strip, title, diagnostic },
  inactive = {
    mod(strip, { color = {} }),
    mod(title, { color = {} }),
    mod(diagnostic, { colored = false, update_in_insert = true }),
  },
}

local M = {}

M.filetypes = { "Trouble" }

M.sections = { lualine_c = components.active }

M.inactive_sections = { lualine_c = components.inactive }

return M
