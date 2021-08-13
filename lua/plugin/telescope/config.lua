local telescope = require("telescope")

telescope.setup({
  defaults = {
    prompt_prefix = "   ",
    selection_caret = " ",
    layout_strategy = "flex",
    layout_config = {
      horizontal = {
        height = 0.8,
        preview_width = 80,
      },
      vertical = {
        height = 0.8,
        width = 0.6,
        preview_height = 0.5,
      },
    },
    file_ignore_patterns = { "%.o", "%.class", },
    winblend = 20,
  },
})
