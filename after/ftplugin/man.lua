local a = vim.api
local set = a.nvim_set_option_value

-- set("signcolumn", "yes:1", { win = 0 })
set(
  "statusline",
  table.concat({
    "%=%#StatusLineDim#MAN%* ",
    "%#StatusLineFilename#%t%* ",
    "%#StatusLineDim#Line%* %3l %#StatusLineDim#of%* %L%=",
  }),
  { win = 0 }
)

a.nvim_create_autocmd({ "WinEnter", "BufWinEnter" }, {
  group = a.nvim_create_augroup("ftplugin/man: :quit if on last window", {}),
  callback = function(ctx)
    local ft = a.nvim_get_option_value("filetype", { buf = ctx.buf })
    if
      a.nvim_buf_get_name(ctx.buf) == "" and ft == ""
      or (#a.nvim_list_wins() == 1 and ft == "qf")
    then
      a.nvim_cmd({ cmd = "quit" }, {})
    end
  end,
  nested = true,
})

local nmap = {}
nmap["<Space>"] = "<C-d>"
nmap["<S-Space>"] = "<C-u>"
nmap.d = "<C-d>"
nmap.D = "<C-u>"
nmap.i = "<Nop>"
nmap.o = function()
  require("man").show_toc()
end
nmap.u = "<C-u>"
-- TODO: find the difference with https://github.com/neovim/neovim/pull/30819
nmap.q = function()
  vim.cmd.lclose() -- close ToC
  vim.schedule(function()
    vim.api.nvim_buf_delete(0, {})
  end)
end
nmap.Q = function()
  vim.cmd.lclose()
  vim.schedule(function()
    vim.cmd.quit({ bang = true })
  end)
end

local map = a.nvim_buf_set_keymap
local opt = { silent = true, noremap = true, nowait = true }
for key, fn in pairs(nmap) do
  local rhs = type(fn) == "function" and "" or fn
  opt.callback = rhs == "" and fn or nil
  map(0, "n", key, rhs, opt)
end
