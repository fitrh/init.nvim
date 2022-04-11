local todo = require("todo-comments")

todo.setup({
  keywords = {
    FIX = { icon = " " },
    TODO = { icon = " " },
    DONE = { icon = " ", color = "success" },
    HACK = { icon = " ", color = "hack" },
    WARN = { icon = "裂" },
    PERF = { icon = "龍" },
    NOTE = { icon = " ", alt = { "INFO", "NB" } },
    LINK = { icon = " ", color = "link", alt = { "SEE", "REF" } },
    SUCCESS = { icon = " ", color = "success", alt = { "OK" } },
    ERROR = { icon = " ", color = "error", alt = { "ERR" } },
  },
  highlight = { max_line_len = 120 },
  colors = {
    hack = { "Function" },
    link = { "FloatBorder" },
    success = { "healthSuccess", "DiagnosticInfo" },
    default = { "Identifier" },
  },
})

-- FIX: some bug, need fix    律 盛
-- WARN: caution
-- TODO: that i never do  ﱔ   
-- DONE: isn't it ?
-- NOTE: i never read this    ﲀ 﨧
-- HACK: tricky      שּׂ ﭩ 
-- PERF: this can be optimized    龍
-- OK: it's okay  ﲏ
-- ERR: boom  ﮏ 
-- SEE: https://github.com/fitrh        陵
