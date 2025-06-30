-- Customize 'intro' via ftplugin when no file argument are given
local augroup = vim.api.nvim_create_augroup("hijack_intro", {})
vim.api.nvim_create_autocmd({ "UIEnter", "StdinReadPre" }, {
  group = augroup,
  callback = function(args)
    -- argc() doesn't count stdin (`cmd | nvim -`)
    if args.event == "StdinReadPre" then
      vim.api.nvim_del_augroup_by_id(augroup)
      return true
    end

    if vim.fn.argc() > 0 then
      return true
    end

    vim.api.nvim_set_option_value("filetype", "intro", {
      -- scope = "local", -- 0.10: `scope` and `buf` can't be used together
      buf = args.buf,
    })
  end,
  once = true,
})
