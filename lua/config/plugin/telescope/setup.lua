local telescope = require("telescope")
local config = {}

config.defaults = {
  layout_strategy = "flex",
  layout_config = {
    horizontal = { preview_width = 0.6 },
  },
  prompt_prefix = " → ", -- digraph: ->
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
    "%.bmp$",
    "%.class$",
    "%.dmg$",
    "%.gif$",
    "%.gz$",
    "%.iso$",
    "%.jar$",
    "%.jpg$",
    "%.JPG$",
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
    "%.svg$",
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
  disable_devicons = true, -- SEE: https://github.com/nvim-telescope/telescope.nvim/issues/1222
}

pickers.buffers = {
  layout_config = { height = 0.4 },
  theme = "dropdown",
  previewer = false,
  mappings = {
    i = {
      ["<C-d>"] = require("telescope.actions").delete_buffer,
    },
  },
  disable_devicons = true,
}

pickers.help_tags = {
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
  theme = "dropdown",
  disable_devicons = true,
}

pickers.filetypes = {
  layout_config = {
    width = 0.25,
    height = 0.5,
  },
}

pickers.git_commits = {
  layout_config = pickers.live_grep.layout_config,
  theme = "dropdown",
}
pickers.git_bcommits = pickers.git_commits
pickers.git_branches = {
  theme = "dropdown",
  previewer = false,
}
pickers.git_status = {
  layout_config = { horizontal = { preview_width = 0.6 } },
  git_icons = {
    renamed = "→",
  },
}

pickers.lsp_document_symbols = {
  layout_config = {
    anchor = "N",
    height = 0.35,
    mirror = true,
    width = 0.50,
  },
  previewer = false,
  theme = "dropdown",
}
pickers.lsp_workspace_symbols = {
  layout_config = { height = 0.4 },
  theme = "ivy",
}
pickers.lsp_references = {
  layout_strategy = "vertical",
  layout_config = {
    preview_cutoff = 10,
    preview_height = 0.55,
    anchor = "S",
    width = 0.7,
    height = 0.9,
  },
}
pickers.lsp_implementations = pickers.lsp_references
pickers.lsp_definitions = pickers.lsp_references

pickers.diagnostics = {
  layout_config = { height = 0.4 },
  theme = "ivy",
  previewer = false,
}

config.pickers = pickers
config.extensions = {
  file_browser = {
    hide_parent_dir = true,
    prompt_path = true,
    mappings = {
      i = {
        ["<C-e>"] = telescope.extensions.file_browser.actions.goto_parent_dir,
        ["<M-f>"] = telescope.extensions.file_browser.actions.toggle_browser,
      },
    },
    git_status = false,
    disable_devicons = true,
  },
  ["zf-native"] = {},
}

telescope.setup(config)
for extension, _ in pairs(config.extensions) do
  telescope.load_extension(extension)
end
