local config = {
  timeout = 2500,
  max_width = function()
    local columns = vim.api.nvim_get_option_value("columns", {}) * 0.4
    return math.ceil(math.max(columns, 20))
  end,
  max_height = function()
    local lines = vim.api.nvim_get_option_value("lines", {}) * 0.3
    return math.ceil(math.max(lines, 4))
  end,
  render = "minimal",
  minimum_width = 1,
  top_down = false,
}

require("notify").setup(config)
