return {
  "https://github.com/scalameta/nvim-metals",
  config = function()
    require("config.plugin.metals.setup")
    vim.api.nvim_exec_autocmds("FileType", {
      pattern = { vim.bo.filetype },
      modeline = false,
    })
  end,
  ft = { "sbt", "scala" },
}
