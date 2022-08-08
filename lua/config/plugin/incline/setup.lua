local config = {}

config.render = function(props)
  if vim.api.nvim_buf_get_name(props.buf) == "" then
    return "[No Name]"
  end

  return require("config.plugin.incline.render.inactive")(props)
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

if config.hide and config.hide.cursorline then
  require("sugar.augroup")("InclineMoveToScondLine", function(autocmd)
    autocmd("BufRead", "*", function()
      if
        vim.api.nvim_win_get_cursor(0)[1] > 1
        or vim.api.nvim_buf_line_count(0) < 2
      then
        return
      end

      vim.api.nvim_win_set_cursor(0, { 2, 0 })
    end)
  end)
end

require("incline").setup(config)
