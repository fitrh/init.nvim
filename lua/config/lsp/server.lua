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

  local config = {
    capabilities = require("config.lsp.capability"),
    handlers = require("config.lsp.handler").default(),
    on_attach = function(client, bufnr)
      require("config.lsp.attach").with.all(client, bufnr)
    end,
  }

  if opts then
    for key, value in pairs(opts) do
      config[key] = value
    end
  end

  return config
end

return Server
