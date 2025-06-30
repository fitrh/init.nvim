local telescope = require("telescope")
local config = {}

config.defaults = {
  layout_strategy = "flex",
  layout_config = {
    horizontal = { preview_width = 0.6 },
  },
  prompt_prefix = " → ", -- digraph: `->`
  selection_caret = "  ", -- SEE: https://github.com/nvim-telescope/telescope.nvim/issues/1841
  dynamic_preview_title = true,
  results_title = false,
  mappings = {
    n = {
      ["<M-p>"] = require("telescope.actions.layout").toggle_preview,
    },
    i = {
      -- TODO The delete keymaps (<C-u>, <C-w>, etc.) should close the window if pressed at an empty prompt
      ["<C-u>"] = false,
      ["<C-d>"] = false,
      ["<C-o>"] = "select_drop",
      -- TODO remove `require`, use action name directly
      ["<C-f>"] = require("telescope.actions").preview_scrolling_down,
      ["<C-b>"] = require("telescope.actions").preview_scrolling_up,
      -- SEE https://github.com/nvim-telescope/telescope.nvim/pull/2437
      ["<M-h>"] = "preview_scrolling_left",
      ["<M-j>"] = "results_scrolling_left",
      ["<M-k>"] = "results_scrolling_right",
      ["<M-l>"] = "preview_scrolling_right",
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
  -- TODO: Remove border between prompt and results
  sorting_strategy = "ascending",
  layout_strategy = "center",
  layout_config = { anchor = "S", height = 0.3, preview_cutoff = 10 },
  -- layout_strategy = "horizontal",
  -- layout_config = {
  --   anchor = "S",
  --   prompt_position = "top",
  --   height = 0.4,
  --   width = { padding = 2 },
  --   preview_width = 0.5,
  -- },
  -- borderchars = {
  --   prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
  --   results = { " " },
  --   preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
  -- },
  -- TODO: Add padding for 'bottom_pane' strategy/'iyv' theme
  -- layout_config = { height = 0.4 },
  -- theme = "ivy",
  -- path_display = {
  --   "filename_first", -- SEE https://github.com/nvim-telescope/telescope.nvim/pull/3010
  -- },
  previewer = false,
  disable_devicons = true, -- SEE: https://github.com/nvim-telescope/telescope.nvim/issues/1222
  hidden = true,
}

pickers.quickfix = {
  layout_config = { height = 0.4 },
  theme = "ivy",
  disable_devicons = true,
  fname_width = 60,
}
pickers.loclist = pickers.quickfix

pickers.buffers = {
  layout_config = {
    anchor = "N",
    anchor_padding = 0,
    height = 0.3,
  },
  -- path_display = {
  --   "filename_first", -- SEE https://github.com/nvim-telescope/telescope.nvim/pull/3010
  -- },
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

-- TODO configure `current_buffer_fuzzy_find` picker
-- TODO configure `grep_string` picker
pickers.live_grep = {
  layout_config = {
    anchor = "N",
    height = 0.35,
    mirror = true,
    width = 0.55,
  },
  path_display = {
    "filename_first", -- SEE https://github.com/nvim-telescope/telescope.nvim/pull/3010
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
pickers.git_bcommits = pickers.git_commits -- TODO <C-s> to opens a diff in a horizontal split
pickers.git_bcommits_range = pickers.git_commits
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
    auto_depth = true,
    hide_parent_dir = true,
    prompt_path = true,
    mappings = {
      i = {
        ["<C-e>"] = telescope.extensions.file_browser.actions.goto_parent_dir,
        ["<C-u>"] = telescope.extensions.file_browser.actions.goto_cwd,
        ["<C-w>"] = function(buf, baypass)
          local state = require("telescope.actions.state")
          local picker = state.get_current_picker(buf)
          if picker:_get_prompt() == "" then
            require("telescope").extensions.file_browser.actions.goto_parent_dir(
              buf,
              baypass
            )
          else
            vim.api.nvim_feedkeys(
              vim.api.nvim_replace_termcodes("<C-s-w>", true, false, true),
              "tn",
              true
            )
          end
        end,
        ["<M-f>"] = telescope.extensions.file_browser.actions.toggle_browser,
        ["<M-i>"] = telescope.extensions.file_browser.actions.toggle_respect_gitignore, -- SEE https://github.com/nvim-telescope/telescope-file-browser.nvim/pull/292
        -- TODO use `attach_mappings`, SEE `:h telescope.mappings`
        -- TODO <C-v>: open or create in vert split
        -- TODO <C-s>: open or create in split
        -- TODO <CR>|<S-CR>: supports brace expansion
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
