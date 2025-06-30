local set = vim.opt_local

-- set.buflisted = false
-- set.modified = false
set.number = false
set.relativenumber = false
set.signcolumn = "yes"
-- set.statuscolumn = "%=%{v:relnum?v:relnum:v:lnum} "
set.winhighlight = "Normal:StatusLine,WinSeparator:ColorColumn"

local a = vim.api
local setl = a.nvim_set_option_value
local localwin = { scope = "local", win = 0 }

-- local bufname = vim.split(a.nvim_buf_get_name(0), "//")
-- local stl = { " %#StatusLineDim#TERM%#StatusLine# ", bufname[#bufname] }
-- setl("statusline", " %#StatusLineDim#TERM%* %t", localwin)
setl("statusline", " %=%f%= ", localwin)
setl("winfixheight", true, localwin)

local nmap = {}
nmap.d = "<C-d>"
nmap.u = "<C-u>"
nmap.q = function()
  a.nvim_buf_delete(0, { force = true })
end

local map = a.nvim_buf_set_keymap
local opt = { silent = true, noremap = true }
for key, fn in pairs(nmap) do
  local rhs = type(fn) == "function" and "" or fn
  opt.callback = rhs == "" and fn or nil
  map(0, "n", key, rhs, opt)
end
