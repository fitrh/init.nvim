local API = {
  SEVERITY = vim.diagnostic.severity,
  GET = vim.diagnostic.get,
}
local SEVERITIES = { "ERROR", "WARN", "INFO", "HINT" }

local function workspace()
  local result = {}

  for _, severity in ipairs(SEVERITIES) do
    local key = string.lower(severity)
    result[key] = #API.GET(nil, { severity = API.SEVERITY[severity] })
  end

  return result
end

local component = {}
component.workspace = { "diagnostics", sources = { workspace } }
component.buffer = { "diagnostics", sources = { "nvim_diagnostic" } }

return component
