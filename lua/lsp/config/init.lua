local handler = require("lsp.handler")
local attach = require("lsp.attach")
local capabilities = require("lsp.capability")

local Config = {}

---@class LspConfig
---@field cmd string|table
---@field cmd_cwd string
---@field cmd_env table
---@field workspace_folder table
---@field capabilities table
---@field handlers table
---@field settings table
---@field command table
---@field init_options table
---@field name string
---@field get_language_id function(bufnr, filetype) -> string

---Base configuration for `vim.lsp.start_client`
---@param bin string #binary executable name
---@param opts LspConfig #`vim.lsp.start_client` config
---@return table LspConfig
function Config.with(bin, opts)
  if vim.fn.executable(bin) ~= 1 then
    return false
  end

  local config = {
    capabilities = capabilities,
    handlers = handler.default(),
    on_attach = attach.with.all,
  }

  if opts then
    for key, value in pairs(opts) do
      config[key] = value
    end
  end

  return config
end

return Config
