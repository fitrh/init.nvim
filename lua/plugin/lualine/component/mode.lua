local palette = require("plugin.themes.palette")
local highlight = require("lib.highlight")

return {
  function()
    local modes = {
      n = { text = "NRM", color = palette.blue },
      i = { text = "INS", color = palette.green.primary },
      v = { text = "VIS", color = palette.purple },
      [""] = { text = "VBL", color = palette.purple },
      V = { text = "VLN", color = palette.purple },
      c = { text = "CMD", color = palette.orange },
      s = { text = "SEL", color = palette.purple },
      S = { text = "SLN", color = palette.purple },
      [""] = { text = "SBL", color = palette.purple },
      t = { text = "TRM", color = palette.red },
    }
    local mode = modes[vim.api.nvim_get_mode().mode]
    highlight.set("LualineComponentMode", {
      fg = mode.color,
      bg = palette.bg_statusline,
      style = "BOLD",
    })
    highlight.set("LualineComponentLines", {
      fg = mode.color,
      bg = palette.bg_statusline,
    })
    return mode.text
  end,
  color = "LualineComponentMode",
}
