return {
  "mfussenegger/nvim-jdtls",
  config = function()
    local command = require("sugar.command")
    local augroup = require("sugar.augroup")
    local config = require("plugin.jdtls.config")

    command.add("JdtStart", config)
    augroup("AttachJDTLS", { "FileType", callback = config, pattern = "java" })
  end,
  ft = { "java" },
  module = "jdtls",
}
