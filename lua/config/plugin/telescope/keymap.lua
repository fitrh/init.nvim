local keymap = require("sugar.keymap")
local map, leader = keymap.map, keymap.modifier.leader
local mode = keymap.mode
local n, x = mode.normal, mode.visual

keymap.bind({
  n(map(leader("r"), function()
    require("telescope.builtin").resume()
  end)),
  n(map("gb", function()
    local bufs = vim
      .iter(vim.api.nvim_list_bufs())
      :filter(function(buf)
        return vim.api.nvim_get_option_value("buflisted", { buf = buf })
      end)
      :totable()
    require("telescope.builtin").buffers(
      require("telescope.themes").get_dropdown({
        -- layout_config = { anchor = "N", anchor_padding = 0, height = #bufs + 3 },
        -- TODO: add limit of 30% of screen height
        layout_config = { anchor = "S", height = #bufs + 3 },
        ignore_current_buffer = true,
        sort_mru = true,
      })
    )
  end)),
  n(map(leader("h"), function()
    require("telescope.builtin").help_tags()
  end)),
  n(map("gf", function() -- NOTE: Potential candidates: g/ go
    require("telescope.builtin").find_files()
  end)),
  n(map("gF", function()
    require("telescope.builtin").live_grep()
  end)),
  -- TODO: open file_browser in current buffer directory
  n(map(leader("e"), function()
    local height = vim.v.count / 10
    require("telescope").extensions.file_browser.file_browser(
      require("telescope.themes").get_ivy({
        layout_config = {
          height = (height > 0 and height < 1) and height or 0.5,
          horizontal = { preview_width = 0.5 },
        },
        previewer = false,
        git_status = true,
      })
    )
  end)),
  n(map(leader("k"), function()
    require("telescope").extensions.file_browser.file_browser(
      require("telescope.themes").get_dropdown({
        previewer = false,
        files = false,
        display_stat = false,
      })
    )
  end)),
  n(map(leader("ft"), function()
    require("telescope.builtin").filetypes()
  end)),
  n(map(leader("lo"), function()
    require("telescope.builtin").treesitter()
  end)),
  n(map(leader("gf"), function()
    require("telescope.builtin").git_files()
  end)),
  n(map("gCc", function()
    require("telescope.builtin").git_commits()
  end)),
  n(map("gCb", function()
    require("telescope.builtin").git_bcommits()
  end)),
  n(map("gCl", function()
    require("telescope.builtin").git_bcommits_range() -- https://github.com/nvim-telescope/telescope.nvim/pull/2398
  end)),
  x(map("gC", function()
    require("telescope.builtin").git_bcommits_range()
  end)),
  n(map("gB", function()
    require("telescope.builtin").git_branches()
  end)),
  n(map("gS", function()
    require("telescope.builtin").git_status({ on_complete = {} }) -- Override `on_complete` to silence the "No change found" notification
  end)),
  n(map(leader("m"), function()
    require("telescope.builtin").keymaps()
  end)),
  n(map("[ld", function()
    require("telescope.builtin").diagnostics(
      require("telescope.themes").get_dropdown({
        bufnr = 0,
      })
    )
  end)),
  n(map("[lD", function()
    require("telescope.builtin").diagnostics()
  end)),
})

-- TODO: remove, use built-in mechanism, i.e. quickfix list
require("sugar.augroup")("attach_telescope_lsp_keymap", function(autocmd)
  autocmd("LspAttach", "*", function(args)
    if not args.data then
      return
    end

    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end
    local capabilities_map = {
      documentSymbolProvider = {
        key = "[ls",
        fn = function()
          require("telescope.builtin").lsp_document_symbols()
        end,
      },
      workspaceSymbolProvider = {
        key = "[lS",
        fn = function()
          require("telescope.builtin").lsp_workspace_symbols()
        end,
      },
      referencesProvider = {
        key = "[lr",
        fn = function()
          require("telescope.builtin").lsp_references({
            fname_width = 50,
            trim_text = true,
          })
        end,
      },
      implementationProvider = {
        key = "[li",
        fn = function()
          require("telescope.builtin").lsp_implementations()
        end,
      },
      definitionProvider = {
        key = "[gd",
        fn = function()
          require("telescope.builtin").lsp_definitions()
        end,
      },
    }

    for capability, bind in pairs(capabilities_map) do
      if client.server_capabilities[capability] then
        vim.api.nvim_buf_set_keymap(args.buf, "n", bind.key, "", {
          silent = true,
          noremap = true,
          callback = bind.fn,
        })
      end
    end
  end)
end)
