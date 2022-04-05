local keymap = require("sugar.keymap")
local map, n = keymap.map, keymap.mode.normal

keymap.bind({
  n(map("[tq", function()
    require("todo-comments.search").setqflist()
  end)),
  n(map("[tl", function()
    require("todo-comments.search").setloclist()
  end)),
  n(map("[tt", function()
    require("trouble").open("todo")
  end)),
  n(map("[lc", function()
    require("telescope").extensions["todo-comments"].todo(
      require("telescope.themes").get_ivy({
        layout_config = { height = 0.5 },
        prompt_prefix = "   ",
        previewer = false,
      })
    )
  end)),
})
