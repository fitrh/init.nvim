local dressing = require("dressing")
local config = {}

config.input = {
  anchor = "NW",
  winblend = vim.api.nvim_get_option("pumblend"),
}

config.select = {
  winblend = vim.api.nvim_get_option("pumblend"),
  format_item_override = {
    codeaction = function(action_tuple)
      local title = action_tuple[2].title:gsub("\r\n", "\\r\\n")
      local client = vim.lsp.get_client_by_id(action_tuple[1])
      return string.format(" %s [%s] ", title:gsub("\n", "\\n"), client.name)
    end,
  },
  get_config = function(opts)
    if opts.kind == "codeaction" then
      return { backend = "builtin", builtin = { relative = "cursor" } }
    end
  end,
}

dressing.setup(config)
