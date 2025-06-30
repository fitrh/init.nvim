local config = require("metals").bare_config()
config.capabilities = require("config.lsp.capability")
config.handlers = require("config.lsp.handler").default()
config.on_attach = require("config.lsp.attach").with.all

local a = vim.api
a.nvim_create_autocmd("FileType", {
  group = a.nvim_create_augroup("nvim-metals", { clear = true }),
  pattern = { "scala", "sbt" },
  callback = function()
    require("metals").initialize_or_attach(config)
  end,
})
