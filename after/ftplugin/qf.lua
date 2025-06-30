local a = vim.api
local set = a.nvim_set_option_value
local localwin = { win = 0 }

-- TODO: Customize `'quickfixtextfunc'`
set("buflisted", false, { buf = 0 })
set("colorcolumn", "", localwin)
set("scrolloff", 0, localwin)
set("signcolumn", "no", localwin)
local stl = table.concat({
  " %q ",
  "%#StatusLine#%",
  #tostring(a.nvim_buf_line_count(0)),
  "l%#StatusLineDim#/%#StatusLine#%L",
})
set("statusline", stl, localwin)
set("winhighlight", "Normal:NormalFloat", localwin)

-- TODO: explore `QuickFixCmd*` events
local function next()
  if vim.fn.getwininfo(vim.api.nvim_get_current_win())[1].loclist == 1 then
    vim.cmd.lnext()
  else
    vim.cmd.cnext()
  end
end

local function prev()
  if vim.fn.getwininfo(vim.api.nvim_get_current_win())[1].loclist == 1 then
    vim.cmd.lprev()
  else
    vim.cmd.cprev()
  end
end

local nmap = {}
nmap["<C-n>"] = next
nmap["<C-p>"] = prev
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

-- TODO: fix
-- local gmap = a.nvim_set_keymap
--
-- gmap("n", "]q", "", {
--   callback = function()
--     next()
--   end,
--   silent = true,
--   noremap = true,
-- })
--
-- gmap("n", "[q", "", {
--   callback = function()
--     prev()
--   end,
--   silent = true,
--   noremap = true,
-- })
