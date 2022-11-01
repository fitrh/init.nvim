local todo = require("todo-comments")

todo.setup({
  keywords = {
    FIX = { icon = " " },
    TODO = { icon = " ", alt = { "WIP" } },
    WARN = { icon = "裂" },
    PERF = { icon = "龍" },
    NOTE = { icon = " ", alt = { "INFO" } },
    TEST = { icon = " " },
    LINK = { icon = " ", color = "link", alt = { "SEE", "REF" } },
  },
  highlight = { max_line_len = 120 },
  colors = {
    test = { "TodoTest", "Comment" },
    link = { "TodoLink", "Comment" },
  },
})
