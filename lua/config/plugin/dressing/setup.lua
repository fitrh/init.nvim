local dressing = require("dressing")
local config = {}
local pumblend = vim.api.nvim_get_option("pumblend")

config.input = {
  insert_only = false,
  anchor = "NW",
  win_options = {
    winblend = pumblend,
  },
}

config.select = {
  builtin = {
    win_options = {
      winblend = pumblend,
    },
  },
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
