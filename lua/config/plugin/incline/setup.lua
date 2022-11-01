local config = {}

config.render = function(props)
  if props.focused then
    if vim.api.nvim_win_get_cursor(0)[1] == vim.fn.line("w0") then
      return nil
    end

    local buf = vim.b[props.buf]
    if not buf.lsp_attached or not buf.nvim_navic_attached then
      return nil
    end

    return require("config.plugin.incline.render.focus")()
  end

  if vim.api.nvim_buf_get_name(props.buf) == "" then
    return " [No Name] "
  end

  return require("config.plugin.incline.render.unfocus")(props)
end

config.window = {
  margin = { horizontal = { left = 0, right = 0 } },
  padding = { left = 0, right = 0 },
  options = {
    winblend = vim.api.nvim_get_option("pumblend"),
  },
  zindex = 25,
}

require("incline").setup(config)
