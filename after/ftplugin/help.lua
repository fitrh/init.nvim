local set = vim.api.nvim_set_option_value
local win = { scope = "local", win = 0 }

set("colorcolumn", "", win)
set("number", true, win)
set("relativenumber", true, win)
set("statuscolumn", " %=%(%{&rnu && v:relnum ? v:relnum : v:lnum} %)", win)
local stl = "%=%#StatusLineDim#HELP%* %#StatusLineFilename#%f%* (%P)%="
set("statusline", stl, win)
set("virtualedit", "all", win)
-- set("winhighlight", "Normal:NormalFloat,SignColumn:NormalFloat", win)

local ns = vim.api.nvim_create_namespace("after/ftplugin/help")
vim.api.nvim_set_hl(ns, "Normal", { link = "NormalFloat" })
vim.api.nvim_set_hl(ns, "NormalNC", { link = "CursorLine" })
vim.api.nvim_set_hl(ns, "SignColumn", { link = "NormalFloat" })
vim.api.nvim_set_hl(ns, "StatusLineNC", { link = "NormalNC" })
vim.schedule(function()
  vim.api.nvim_win_set_hl_ns(0, ns)
end)
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  group = vim.api.nvim_create_augroup("after/ftplugin/help", {}),
  callback = function(args)
    if vim.bo[args.buf].filetype ~= "help" then
      if vim.api.nvim_get_hl_ns({ winid = 0 }) == ns then
        vim.api.nvim_win_set_hl_ns(0, 0)
      end
      return
    end

    vim.api.nvim_win_set_hl_ns(0, ns)
  end,
})

local nmap = {}
nmap.d = "<C-d>"
nmap.D = "<C-u>"
nmap.o = function()
  vim.api.nvim_feedkeys("gO", "x", true)
end
nmap.q = function()
  vim.cmd.lclose() -- close ToC
  vim.api.nvim_buf_delete(0, { force = true })
end
nmap.u = "<C-u>"

local map = vim.api.nvim_buf_set_keymap
local opt = { silent = true, noremap = true }
for key, fn in pairs(nmap) do
  local rhs = type(fn) == "function" and "" or fn
  opt.callback = rhs == "" and fn or nil
  map(0, "n", key, rhs, opt)
end
