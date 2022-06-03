local Component = {}

---@param width? number @default = 1
---@return table component
function Component.spacer(width)
  local spaces = string.rep(" ", width or 1)
  return {
    function()
      return spaces
    end,
    padding = 0,
  }
end

---@alias StripAlignment
---| '"left"'
---| '"right"'

---@param alignment? StripAlignment @default "left"
---@return table component
function Component.strip(alignment)
  local char = require("const.LINE_CHAR").THIN[alignment or "left"]
  return {
    function()
      return char
    end,
    padding = 0,
  }
end

Component.mode = require("config.plugin.lualine.component.mode")
Component.file = require("config.plugin.lualine.component.file")
Component.state = require("config.plugin.lualine.component.state")
Component.git = require("config.plugin.lualine.component.git")
Component.diagnostic = require("config.plugin.lualine.component.diagnostic")

return Component
