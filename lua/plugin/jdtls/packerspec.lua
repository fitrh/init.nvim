return {
  "mfussenegger/nvim-jdtls",
  config = function()
    local command = require("sugar.command")
    local event = require("sugar.event")
    local config = require("plugin.jdtls.config")

    command.add("JdtStart", config)
    event.augroup("AttachJDTLS", { event.autocmd("FileType", "java", config) })
  end,
  ft = { "java" },
  module = "jdtls",
}
