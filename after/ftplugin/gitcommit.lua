local set = vim.api.nvim_set_option_value
local localwin = { scope = "local", win = 0 }
set("colorcolumn", "51,73", localwin)
set("scrolloff", 0, localwin)

-- split window to shows the diff
-- requires `git commit -v` command or `commit.verbose` git-config
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("after/ftplugin/gitcommit", {}),
  pattern = "COMMIT_EDITMSG",
  callback = function()
    vim.schedule(function()
      local ex = vim.api.nvim_cmd

      -- split the window, use vertical split if the window can be split into 2 80-columns windows
      local vert = vim.api.nvim_get_option_value("columns", {}) >= 160
      ex({ cmd = "split", mods = { split = "botright", vertical = vert } }, {})
      vim.api.nvim_call_function("search", { "diff --git" }) -- go to the diff section
      ex({ cmd = "normal", args = { "zt" } }, {}) -- move cursor to the top of the window
      ex({ cmd = "wincmd", args = { "p" } }, {}) -- move to previous window
    end)
  end,
  once = true,
})
