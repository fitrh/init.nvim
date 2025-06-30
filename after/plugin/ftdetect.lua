local augroup = vim.api.nvim_create_augroup("after/plugin/ftdetect", {})

vim.api.nvim_create_autocmd("BufWinEnter", {
  group = augroup,
  callback = function(args)
    if vim.api.nvim_get_option_value("filetype", { buf = args.buf }) ~= "" then
      return
    end

    vim.api.nvim_create_autocmd("BufWrite", {
      group = augroup,
      callback = function(a)
        if vim.api.nvim_get_option_value("filetype", { buf = a.buf }) == "" then
          vim.cmd.filetype("detect")
        end
      end,
      buffer = args.buf,
      once = true,
    })
  end,
})
