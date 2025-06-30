local Server = {}

---Base configuration for `vim.lsp.start_client`
---@param bin string binary executable name
---@param opts? vim.lsp.ClientConfig|{ cmd?: string|string[] }
---@return vim.lsp.ClientConfig|boolean
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
