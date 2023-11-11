local config = {
  timeout = 2500,
  max_width = function()
    return math.floor(math.max(vim.api.nvim_get_option("columns") / 2, 20))
  end,
  max_height = function()
    return math.floor(math.max(vim.api.nvim_get_option("lines") / 3, 4))
  end,
  render = "minimal",
  minimum_width = 1,
  top_down = false,
}

require("notify").setup(config)
