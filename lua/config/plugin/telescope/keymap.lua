local keymap = require("sugar.keymap")
local map, leader, n = keymap.map, keymap.modifier.leader, keymap.mode.normal

keymap.bind({
  n(map("gb", function()
    require("telescope.builtin").buffers({
      ignore_current_buffer = true,
      sort_mru = true,
    })
  end)),
  n(map(leader("h"), function()
    require("telescope.builtin").help_tags()
  end)),
  n(map("gf", function()
    require("telescope.builtin").find_files()
  end)),
  n(map("gF", function()
    require("telescope.builtin").live_grep()
  end)),
  n(map(leader("e"), function()
    require("telescope").extensions.file_browser.file_browser({
      auto_depth = true,
    })
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
  n(map("gB", function()
    require("telescope.builtin").git_branches()
  end)),
  n(map("gS", function()
    require("telescope.builtin").git_status()
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

require("sugar.augroup")("attach_telescope_lsp_keymap", function(autocmd)
  autocmd("LspAttach", "*", function(args)
    if not args.data then
      return
    end

    local client = vim.lsp.get_client_by_id(args.data.client_id)
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
