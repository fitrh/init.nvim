local Server = {}

---@class ServerConfig
---@field cmd? string[]
---@field cmd_cwd? string
---@field cmd_env? table
---@field workspace_folder? table
---@field capabilities? table
---@field handlers? table
---@field settings? table
---@field command? table
---@field init_options? table
---@field name? string
---@field get_language_id? fun(bufnr: number, filetype: string):string

---Base configuration for `vim.lsp.start_client`
---@param bin string #binary executable name
---@param opts? ServerConfig #`vim.lsp.start_client` config
---@return boolean|table ServerConfig
function Server.with(bin, opts)
  if vim.fn.executable(bin) ~= 1 then
    return false
  end

  local config = {}
  for k, v in pairs(opts or {}) do
    config[k] = v
  end

  if not config.capabilities then
    config.capabilities = require("config.lsp.capability")
  end

  if not config.handlers then
    config.handlers = require("config.lsp.handler").default()
  end

  if not config.on_attach then
    config.on_attach = require("config.lsp.attach").with.all
  end

  return config
end

return Server
