local palette = require("plugin.themes.palette")

return {
  modified = {
    function()
      return ""
    end,
    cond = function()
      return vim.api.nvim_buf_get_option(0, "modified")
    end,
    color = { fg = palette.red_br_2 },
  },

  readonly = {
    function()
      return ""
    end,
    cond = function()
      local readonly = vim.api.nvim_buf_get_option(0, "readonly")
      local modifiable = vim.api.nvim_buf_get_option(0, "modifiable")
      return readonly or not modifiable
    end,
    color = { fg = palette.red1 },
  },
}
