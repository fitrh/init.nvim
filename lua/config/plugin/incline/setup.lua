local config = {}

config.render = function(props)
  if vim.api.nvim_buf_get_name(props.buf) == "" then
    return "[No Name]"
  end

  return require("config.plugin.incline.render.path_state_filename")(props)
end

config.window = {
  margin = { horizontal = { left = 1, right = 0 } },
  padding = { left = 0, right = 1 },
  options = {
    winblend = vim.api.nvim_get_option("pumblend"),
  },
  zindex = 25,
}

config.hide = {
  focused_win = true,
  cursorline = true,
}

require("incline").setup(config)
