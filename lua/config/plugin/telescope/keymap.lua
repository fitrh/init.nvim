local keymap = require("sugar.keymap")
local map, leader, n = keymap.map, keymap.modifier.leader, keymap.mode.normal

keymap.bind({
  n(map("gb", function()
    require("telescope.builtin").buffers()
  end)),
  n(map("gf", function()
    require("telescope.builtin").find_files()
  end)),
  n(map("gF", function()
    require("telescope.builtin").live_grep()
  end)),
  n(map(leader("e"), function()
    require("telescope").extensions.file_browser.file_browser()
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
  n(map("gC", function()
    require("telescope.builtin").git_commits()
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
