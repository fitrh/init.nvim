return {
  "akinsho/flutter-tools.nvim",
  -- TODO: Add `telescope.nvim` as dependency
  requires = "nvim-lua/plenary.nvim",
  config = function()
    require("config.plugin.flutter-tools.setup")
    require("config.plugin.flutter-tools.keymap")
    -- vim.api.nvim_exec_autocmds("FileType", { pattern = "dart" })
    vim.api.nvim_exec_autocmds("FileType", {
      pattern = vim.bo.filetype,
      modeline = false,
    }) -- SEE: https://github.com/neovim/neovim/issues/23368
  end,
  ft = "dart",
  event = "BufRead pubspec.yaml",
}
