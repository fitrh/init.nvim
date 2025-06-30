return {
  "simrat39/rust-tools.nvim",
  config = function()
    require("config.plugin.rust-tools.setup")
    vim.api.nvim_exec_autocmds("FileType", {
      pattern = "rust",
      modeline = false,
    })
  end,
  ft = { "rust" },
}
