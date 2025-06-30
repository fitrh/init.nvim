local set = vim.opt_local
set.expandtab = false

vim.api.nvim_buf_set_keymap(0, "n", "<Leader>xx", "", {
  desc = "after/ftplugin/sh.lua: Mark the file as executable",
  callback = function()
    -- TODO: Determie file mode with vim.uv.fs_stat, don't mark it as executable
    --       if it is already executable
    vim.cmd("silent !chmod 744 %")
  end,
})
