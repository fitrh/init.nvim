return {
  "jose-elias-alvarez/typescript.nvim",
  requires = {
    { "neovim/nvim-lspconfig", module = "lspconfig" },
  },
  config = function()
    require("config.plugin.typescript.setup")
    vim.api.nvim_exec_autocmds("FileType", {
      pattern = vim.bo.filetype,
      modeline = false,
    }) -- SEE: https://github.com/neovim/neovim/issues/23368
    -- vim.api.nvim_create_autocmd("BufWinEnter", {
    --   group = vim.api.nvim_create_augroup("typescript_packerspec", {}),
    --   callback = function(args)
    --     if
    --       vim.api.nvim_get_option_value("filetype", { buf = args.buf }) ~= ""
    --     then
    --       require("config.plugin.typescript.setup")
    --       return true
    --     end
    --   end,
    -- })
  end,
  ft = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
}
