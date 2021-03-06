require("litee.lib").setup({
  panel = {
    orientation = "right",
    panel_size = math.ceil(vim.api.nvim_get_option("columns") / 4),
  },
})

require("litee.symboltree").setup({
  icon_set = "nerd",
  hide_cursor = false,
  on_open = "panel",
})

require("litee.calltree").setup({
  icon_set = "nerd",
  hide_cursor = false,
  on_open = "panel",
})
