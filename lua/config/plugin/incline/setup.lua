local config = {}

config.render = function(props)
  if vim.api.nvim_buf_get_name(props.buf) == "" then
    return " [No Name] "
  end

  if props.focused then
    if not vim.b[props.buf].lsp_attached then
      return nil
    end

    if not vim.b[props.buf].nvim_navic_attached then
      return nil
    end

    return require("config.plugin.incline.render.focus")()
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

config.hide = {
  cursorline = true,
}

if config.hide and config.hide.cursorline then
  require("sugar.augroup")("incline_manage_cursor", function(autocmd)
    autocmd({ "UIEnter", "BufRead" }, "*", function()
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
