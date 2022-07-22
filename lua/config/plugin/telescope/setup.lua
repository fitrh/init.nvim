local telescope = require("telescope")
local config = {}

config.defaults = {
  layout_strategy = "flex",
  layout_config = {
    horizontal = { preview_width = 80 },
  },
  prompt_prefix = "   ",
  selection_caret = " ",
  dynamic_preview_title = true,
  results_title = false,
  mappings = {
    n = {
      ["<M-p>"] = require("telescope.actions.layout").toggle_preview,
    },
    i = {
      ["<M-p>"] = require("telescope.actions.layout").toggle_preview,
      ["<C-[>"] = require("telescope.actions").close,
      ["<C-j>"] = require("telescope.actions").cycle_history_next,
      ["<C-k>"] = require("telescope.actions").cycle_history_prev,
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

local pickers = {}

pickers.find_files = {
  layout_config = { height = 0.50 },
  path_display = { "smart" },
  theme = "ivy",
  previewer = false,
}

pickers.buffers = {
  prompt_prefix = "   ",
  path_display = { "smart" },
  theme = "dropdown",
  previewer = false,
  mappings = {
    i = {
      ["<C-d>"] = require("telescope.actions").delete_buffer,
    },
  },
}

pickers.live_grep = {
  layout_config = {
    anchor = "N",
    height = 0.35,
    mirror = true,
    width = 0.55,
  },
  prompt_prefix = "   ",
  theme = "dropdown",
}

pickers.filetypes = {
  layout_config = {
    width = 0.25,
    height = 0.5,
  },
  prompt_prefix = "   ",
}

pickers.git_files = { prompt_prefix = "   ", path_display = { "smart" } }
pickers.git_commits = {
  layout_config = pickers.live_grep.layout_config,
  prompt_prefix = "   ",
  theme = "dropdown",
}
pickers.git_branches = {
  prompt_prefix = "   ",
  theme = "dropdown",
  previewer = false,
}
pickers.git_status = {
  layout_config = { horizontal = { preview_width = 0.55 } },
  prompt_prefix = "   ",
  path_display = { "smart" },
}

pickers.lsp_document_symbols = {
  layout_config = { width = 0.50 },
  prompt_prefix = "   ",
  theme = "dropdown",
}
pickers.lsp_workspace_symbols = {
  layout_config = { height = 0.5 },
  prompt_prefix = "   ",
  theme = "ivy",
}
pickers.lsp_references = { theme = "dropdown" }
pickers.lsp_implementations = pickers.lsp_references
pickers.lsp_definitions = pickers.lsp_references

pickers.diagnostics = {
  layout_config = { height = 0.5 },
  prompt_prefix = "   ",
  theme = "ivy",
  previewer = false,
}

config.pickers = pickers
config.extensions = {
  file_browser = {
    prompt_prefix = "   ",
    hide_parent_dir = true,
    collapse_dirs = true,
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
