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
    file_ignore_patterns = {
      "%.o",
      "%.class",
      ".dart_tool/",
      ".env/",
      ".git/",
      ".github/",
      ".gradle/",
      ".idea/",
      ".settings/",
      ".vscode/",
      "build/",
      "env/",
      "gradle/",
      "node_modules/",
      "target/",
    },
  },
  pickers = {
    find_files = {
      path_display = { "smart" },
      theme = "ivy",
      layout_config = {
        height = 0.4,
      },
    },
    file_browser = {
      prompt_prefix = "   ",
      hidden = true,
    },
    buffers = {
      path_display = { "smart" },
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
    git_files = {
      path_display = { "smart" },
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
