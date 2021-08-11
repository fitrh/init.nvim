local autocmd = require("util.event.autocmd")
local augroup = require("util.event.augroup")


-- format:
--   [events] = { filter, cmd }

-- type:
--   events = string, list of valid vim event name
--   filter = string, optional, pattern to match when the events get fire,
--            default to "*"
--   cmd    = string, vim/ex command to execute
autocmd.setup({
  ["WinEnter,BufEnter,InsertLeave"] = { cmd = "set cul" },
  ["WinLeave,BufLeave,InsertEnter"] = { cmd = "set nocul" },
})


-- format:
--   [name] = {
--     filter, events, { autocmd }, { autocmd }, ...,
--   }

-- type:
--   name = string, augroup name
--   filter = string, optional, the filter that will be used for autocmd if
--            the autocmd filter is omitted
--   events = string, optional, the events that will be used for autocmd if
--            the autocmd events is omitted
--   autocmd = list of table, autocmd spec that belong to the augroup name
--     autocmd format:
--       {
--         events, string, optional, list of valid vim event name
--         filter = string, optional, pattern to match when the events get fire,
--                  default to "*"
--         cmd = string, vim/ex command to execute
--       }
augroup.setup({
  ["TrimOrMakeDir"] = {
    events = "BufWritePre",
    { cmd = [[:%s/\s\+$//e]], },
    { cmd = [[lua require("util.dir").mk()]] },
  },
  ["HighlightOnYank"] = {
    {
      events = "TextYankPost",
      cmd = 'silent! lua vim.highlight.on_yank({ higroup = "Substitute" })',
    },
  },
  ["OnNewJavaBuffer"] = {
    {
      events = "FileType",
      filter = "java",
      cmd = [[lua require("plugin.jdtls.config").attach()]],
    },
  },
})
