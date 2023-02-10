local telescope = require("telescope")
local config = {}

config.defaults = {
  layout_strategy = "flex",
  layout_config = {
    horizontal = { preview_width = 80 },
  },
  prompt_prefix = "   ",
  selection_caret = "  ", -- SEE: https://github.com/nvim-telescope/telescope.nvim/issues/1841
  dynamic_preview_title = true,
  results_title = false,
  mappings = {
    n = {
      ["<M-p>"] = require("telescope.actions.layout").toggle_preview,
    },
    i = {
      ["<C-u>"] = false,
      ["<C-d>"] = false,
      ["<C-f>"] = require("telescope.actions").preview_scrolling_down,
      ["<C-b>"] = require("telescope.actions").preview_scrolling_up,
      ["<C-s>"] = require("telescope.actions").select_horizontal,
      ["<M-p>"] = require("telescope.actions.layout").toggle_preview,
      ["<C-[>"] = require("telescope.actions").close,
      ["<C-j>"] = require("telescope.actions").cycle_history_next,
      ["<C-k>"] = require("telescope.actions").cycle_history_prev,
    },
  },
  -- SEE: https://developer.roblox.com/en-us/articles/string-patterns-reference
  file_ignore_patterns = {
    "%.class$",
    "%.dmg$",
    "%.gif$",
    "%.gz$",
    "%.iso$",
    "%.jar$",
    "%.jpg$",
    "%.jpeg$",
    "%.JPEG$",
    "%.mkv$",
    "%.mp4$",
    "%.o$",
    "%.otf$",
    "%.out$",
    "%.pdf$",
    "%.png$",
    "%.PNG$",
    "%.pyc$",
    "%.pyi$",
    "%.tar",
    "%.torrent$",
    "%.ttf$",
    "%.webm$",
    "%.webp$",
    "%.zip$",
    "^.dart_tool/",
    "^.git/",
    "^.github/",
    "^.gradle/",
    "^.idea/",
    "^.settings/",
    "^.vscode/",
    "^.env/",
    "^__pycache__/",
    "^bin/",
    "^build/",
    "^env/",
    "^gradle/",
    "^node_modules/",
    "^obj/",
    "^target/",
    "^vendor/",
    "^zig%-cache/",
    "^zig%-out/",
  },
}

local pickers = {}

pickers.find_files = {
  layout_config = { height = 0.4 },
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

pickers.help_tags = {
  prompt_prefix = " 龎 ",
  theme = "dropdown",
  previewer = false,
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

pickers.git_files = { prompt_prefix = "   " }
pickers.git_commits = {
  layout_config = pickers.live_grep.layout_config,
  prompt_prefix = "   ",
  theme = "dropdown",
}
pickers.git_bcommits = pickers.git_commits
pickers.git_branches = {
  prompt_prefix = "   ",
  theme = "dropdown",
  previewer = false,
}
pickers.git_status = {
  layout_config = { horizontal = { preview_width = 0.55 } },
  prompt_prefix = "   ",
}

pickers.lsp_document_symbols = {
  layout_config = {
    anchor = "N",
    height = 0.35,
    mirror = true,
    width = 0.50,
  },
  previewer = false,
  prompt_prefix = "   ",
  theme = "dropdown",
}
pickers.lsp_workspace_symbols = {
  layout_config = { height = 0.4 },
  prompt_prefix = "   ",
  theme = "ivy",
}
pickers.lsp_references = { theme = "dropdown" }
pickers.lsp_implementations = pickers.lsp_references
pickers.lsp_definitions = pickers.lsp_references

pickers.diagnostics = {
  layout_config = { height = 0.4 },
  prompt_prefix = "   ",
  theme = "ivy",
  previewer = false,
}

config.pickers = pickers
config.extensions = {
  file_browser = {
    prompt_prefix = "   ",
    hide_parent_dir = true,
    mappings = {
      i = {
        ["<M-f>"] = telescope.extensions.file_browser.actions.toggle_browser,
      },
    },
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
