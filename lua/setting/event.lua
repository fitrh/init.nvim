local augroup = require("lib.event.augroup")

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
--   expect = boolean, a condtion to match to run the autocmd
--   autocmd = list of table, autocmd spec that belong to the augroup name
--     autocmd format:
--       {
--         events, string, optional, list of valid vim event name
--         filter = string, optional, pattern to match when the events get fire,
--                  default to "*"
--         cmd = string, vim/ex command to execute
--       }

augroup.setup({
  ["TrimAndMakeDir"] = {
    events = "BufWritePre",
    { cmd = [[:%s/\s\+$//e]], },
    { cmd = [[lua require("helper.dir").mk()]] },
  },
  ["HighlightOnYank"] = {
    {
      events = "TextYankPost",
      cmd = [[silent! lua vim.highlight.on_yank()]],
    },
  },
  ["CursorlineToggle"] = {
    {
      events = "WinEnter,BufEnter,InsertLeave",
      cmd = "set cursorline",
    },
    {
      events = "WinLeave,BufLeave,InsertEnter",
      cmd = "set nocursorline",
    },
  },
})
