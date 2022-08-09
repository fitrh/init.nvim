return function(client, bufnr)
  local ok, navic = pcall(require, "nvim-navic")
  if not ok then
    return
  end

  navic.attach(client, bufnr)
  vim.api.nvim_buf_set_var(bufnr, "nvim_navic_attached", true)
end
