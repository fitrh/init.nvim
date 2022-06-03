local config = {
  settings = {
    texlab = {
      diagnosticsDelay = vim.api.nvim_get_option("updatetime"),
    },
  },
}

if vim.fn.executable("chktex") == 1 then
  config.settings.texlab.chktex = {
    onOpenAndSave = true,
    onEdit = false,
  }
end

if vim.fn.executable("tectonic") == 1 then
  config.settings.texlab.build = {
    executable = "tectonic",
    args = {
      "-X",
      "compile",
      "%f",
      "--synctex",
      "--keep-logs",
      "--keep-intermediates",
      "--outdir dist",
    },
  }
end

return require("config.lsp.client").with("texlab", config)
