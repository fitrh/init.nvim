local a = vim.api

local stl = "%="
local items = { "help", "edit", "find files", "quit" }
for i, v in ipairs(items) do
  stl = stl .. v:sub(1, 1) .. "%#StatusLineNC#" .. v:sub(2) .. "%*"
  stl = stl .. (i < #items and " ⋮ " or "%=")
end

a.nvim_set_var("intro_stl", stl)
a.nvim_set_option_value("statusline", stl, {
  scope = "local",
  win = 0,
})

local map = a.nvim_buf_set_keymap
local function nmap(key, action, opts)
  opts = opts or { nowait = true }
  if type(action) == "function" then
    opts.callback = action
    action = ""
  end
  map(0, "n", key, action, opts)
end

nmap("e", ":e ") -- FIXME trigger completion
nmap("q", "<Cmd>quit<CR>")
nmap("h", function()
  local ok, telescope = pcall(require, "telescope.builtin")
  if not ok then
    vim.api.nvim_feedkeys(":help ", "t", true) -- FIXME trigger completion
    return
  end

  telescope.help_tags()
end)
nmap("f", function()
  local ok, telescope = pcall(require, "telescope.builtin")
  if not ok then
    vim.api.nvim_feedkeys(":find ", "t", true) -- FIXME trigger completion
    return
  end

  telescope.find_files()
end)
