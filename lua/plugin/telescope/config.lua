local telescope = require("telescope")

telescope.setup({
  defaults = {
    layout_strategy = "flex",
    layout_config = {
      height = 0.8,
      horizontal = { preview_width = 80 },
    },
    winblend = 20,
    prompt_prefix = "   ",
    selection_caret = " ",
    dynamic_preview_title = true,
    file_ignore_patterns = {
      "%.class",
      "%.gif",
      "%.jpg",
      "%.jpeg",
      "%.JPEG",
      "%.o",
      "%.png",
      "%.PNG",
      "%.pyc",
      "%.pyi",
      "%.webp",
      ".dart_tool/",
      ".env/",
      ".git/",
      ".github/",
      ".gradle/",
      ".idea/",
      ".settings/",
      ".vscode/",
      "__pycache__",
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
    },
    file_browser = {
      prompt_prefix = "   ",
      hidden = true,
    },
    buffers = {
      prompt_prefix = " ﬘  ",
      path_display = { "smart" },
      theme = "dropdown",
      previewer = false,
    },
    live_grep = {
      prompt_prefix = "   ",
      theme = "dropdown",
    },
    filetypes = {
      layout_config = {
        width = 0.25,
        height = 0.5,
      },
      prompt_prefix = "   ",
    },
    git_files = {
      path_display = { "smart" },
    },
    git_status = {
      layout_config = { width = 0.5 },
      path_display = { "smart" },
      previewer = false,
      git_icons = {
        added = "",
        changed = "",
        copied = "",
        deleted = "",
        renamed = "",
        unmerged = "",
        untracked = "",
      },
    },
    lsp_code_actions = {
      prompt_prefix = " ﯧ  ",
      theme = "cursor",
    },
    lsp_range_code_actions = {
      prompt_prefix = " ﯧ  ",
      theme = "cursor",
    },
  },
})
