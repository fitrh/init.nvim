local M = {}

function M.config(config)
  config = config or {}

  config.init_options = {
    enable = true,
    lint = true,
  }

  config.single_file_support = false

  return require("config.lsp.server").with("deno", config)
end

return M
