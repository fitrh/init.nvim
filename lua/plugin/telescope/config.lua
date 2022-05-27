local telescope = require("telescope")
local layout = require("telescope.actions.layout")
local config = {}

config.defaults = {
  layout_strategy = "flex",
  layout_config = {
    horizontal = { preview_width = 80 },
  },
  winblend = vim.api.nvim_get_option("pumblend"),
  prompt_prefix = "   ",
  selection_caret = " ",
  dynamic_preview_title = true,
  results_title = false,
  mappings = {
    n = {
      ["<M-p>"] = layout.toggle_preview,
    },
    i = {
      ["<M-p>"] = layout.toggle_preview,
    },
  },
  file_ignore_patterns = {
    "%.class",
    "%.gif",
    "%.jpg",
    "%.jpeg",
    "%.JPEG",
    "%.o",
    "%.out",
    "%.png",
    "%.PNG",
    "%.pyc",
    "%.pyi",
    "%.webp",
    "%.dart_tool/",
    "%.env/",
    "%.git/",
    "%.github/",
    "%.gradle/",
    "%.idea/",
    "%.settings/",
    "%.vscode/",
    "__pycache__/",
    "bin/",
    "build/",
    "env/",
    "gradle/",
    "node_modules/",
    "obj/",
    "target/",
    "vendor/",
    "zig%-cache/",
    "zig%-out/",
  },
}

config.pickers = {
  find_files = {
    layout_config = { height = 0.50 },
    path_display = { "smart" },
    theme = "ivy",
    previewer = false,
  },
  buffers = {
    prompt_prefix = "   ",
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
  git_files = { prompt_prefix = "   ", path_display = { "smart" } },
  git_commits = { prompt_prefix = "   ", theme = "dropdown" },
  git_branches = {
    prompt_prefix = "   ",
    theme = "dropdown",
    previewer = false,
  },
  git_status = {
    layout_config = { horizontal = { preview_width = 0.55 } },
    prompt_prefix = "   ",
    path_display = { "smart" },
  },
  lsp_document_symbols = {
    layout_config = { width = 0.50 },
    prompt_prefix = "   ",
    theme = "dropdown",
  },
  lsp_workspace_symbols = {
    layout_config = { height = 0.5 },
    prompt_prefix = "   ",
    theme = "ivy",
  },
  lsp_references = { theme = "dropdown" },
  lsp_implementations = { theme = "dropdown" },
  lsp_definitions = { theme = "dropdown" },
  diagnostics = {
    layout_config = { height = 0.5 },
    prompt_prefix = "   ",
    theme = "ivy",
    previewer = false,
  },
}

config.extensions = {
  file_browser = {
    prompt_prefix = "   ",
    hide_parent_dir = true,
  },
  fzf = {},
}

telescope.setup(config)

local extensions = {
  "file_browser",
  "fzf",
}

for _, extension in ipairs(extensions) do
  telescope.load_extension(extension)
end
