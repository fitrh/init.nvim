local todo = require("todo-comments")

todo.setup({
  keywords = {
    FIX = { icon = " " },
    TODO = { icon = " ", alt = { "WIP" } },
    WARN = { icon = "裂" },
    PERF = { icon = "龍" },
    NOTE = { icon = " ", alt = { "INFO", "NB" } },
    TEST = { icon = " " },
    DONE = { icon = " ", color = "ok" },
    LINK = { icon = " ", color = "link", alt = { "SEE", "REF" } },
    OK = { icon = " ", color = "ok", alt = { "SUCCESS" } },
    ERROR = { icon = " ", color = "error", alt = { "ERR" } },
  },
  highlight = { max_line_len = 120 },
  colors = {
    test = { "TodoTest", "Comment" },
    link = { "TodoLink", "Comment" },
    ok = { "TodoOk", "Comment" },
  },
})

-- FIX: some bug, need fix    律 盛
-- WARN: caution
-- TODO: that i never do  ﱔ   
-- DONE: isn't it ?
-- NOTE: i never read this    ﲀ 﨧
-- TEST: test?
-- PERF: this can be optimized    龍
-- OK: it's okay  ﲏ
-- ERR: boom  ﮏ 
-- SEE: https://github.com/fitrh        陵
