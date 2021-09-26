local todo = require("todo-comments")

todo.setup({
  keywords = {
    FIX = { icon = " " },
    TODO = { icon = " " },
    HACK = { icon = " ", color = "hack" },
    WARN = { icon = "裂" },
    PERF = { icon = "龍" },
    NOTE = { icon = " ", alt = { "INFO", "NB" } },
    LINK = { icon = " ", color = "ref", alt = { "LINKS", "REF", "REFS" } },
    SUCCESS = { icon = " ", color = "success", alt = { "OK", "DONE" } },
    ERROR = { icon = " ", color = "error", alt = { "ERR" } },
  },
  highlight = { before = "fg", max_line_len = 120 },
  colors = {
    error = { "DiagnosticError" },
    warning = { "DiagnosticWarn" },
    info = { "DiagnosticInfo" },
    hint = { "DiagnosticHint" },
    hack = { "Function" },
    ref = { "FloatBorder" },
    success = { "healthSuccess" },
    default = { "Identifier" },
  },
})

-- FIX: some bug, need fix    律 盛
-- WARN: caution
-- TODO: that i never do  ﱔ  
-- NOTE: i never read this    ﲀ 﨧
-- HACK: tricky      שּׂ ﭩ 
-- PERF: this can be optimized    龍
-- OK: it's okay  ﲏ
-- ERR: boom  ﮏ 
-- REFS: https://github.com/fitrh        陵
