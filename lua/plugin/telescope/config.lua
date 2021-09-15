local telescope = require("telescope")

telescope.setup({
  defaults = {
    prompt_prefix = "   ",
    selection_caret = " ",
    layout_strategy = "flex",
    layout_config = {
      height = 0.8,
      horizontal = {
        preview_width = 80,
      },
    },
    file_ignore_patterns = { "%.o", "%.class" },
  },
  pickers = {
    find_files = {
      theme = "ivy",
      layout_config = {
        height = 0.4,
      },
    },
    buffers = {
      theme = "dropdown",
      prompt_prefix = " ﬘  ",
      previewer = false,
    },
    live_grep = {
      theme = "dropdown",
      prompt_prefix = "   ",
    },
    filetypes = {
      prompt_prefix = "   ",
      layout_config = {
        width = 0.25,
        height = 0.5,
      },
    },
    lsp_code_actions = {
      theme = "cursor",
      prompt_prefix = " ﯧ  ",
    },
    lsp_range_code_actions = {
      theme = "cursor",
      prompt_prefix = " ﯧ  ",
    },
  },
})
