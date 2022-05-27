local setup = require("lsp.config")
local config = {
  settings = {
    texlab = {
      diagnosticsDelay = vim.api.nvim_get_option("updatetime"),
    },
  },
}

if vim.fn.executable("tectonic") == 1 then
  config.settings.texlab.build = {
    executable = "tectonic",
    args = {
      "%f",
      "--synctex",
      "--keep-logs",
      "--keep-intermediates",
      "--outdir dist",
    },
  }
end

return setup.with("texlab", config)
