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
  },
  pickers = {
    find_files = {
      theme = "ivy",
      layout_config = {
        height = 0.4,
      }
    },
    buffers = {
      theme = "dropdown",
      previewer = false,
    },
    live_grep = {
      theme = "dropdown",
    },
    filetypes = {
      layout_config = {
        width = 0.25,
        height = 0.5,
      },
    },
    lsp_code_actions = {
      theme = "cursor",
    },
    lsp_range_code_actions = {
      theme = "cursor",
    },
  },
})
