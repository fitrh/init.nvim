local palette = require("helper.palette")

return {
  modified = {
    function()
      return ""
    end, -- "ﴖ"
    cond = function()
      return vim.bo.modified
    end,
    color = { fg = palette.red_br_2 }, -- palette.blue5
    padding = 0,
  },

  readonly = {
    function()
      return "" -- ""
    end,
    cond = function()
      return vim.bo.readonly or not vim.bo.modifiable
    end,
    color = { fg = palette.red1 },
    padding = { left = 0, right = 1 },
  },
}
