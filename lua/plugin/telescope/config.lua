local telescope = require("telescope")

telescope.setup({
  defaults = {
    prompt_prefix = "   ",
    selection_caret = " ",
    layout_strategy = "flex",
    layout_config = {
      horizontal = {
        height = 0.8,
        -- width = 0.75,
        preview_width = 0.65,
      },
      vertical = {
        height = 0.8,
        width = 0.6,
        preview_height = 0.5,
      },
    },
  },
})
