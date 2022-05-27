return {
  "mfussenegger/nvim-jdtls",
  config = function()
    local command = require("sugar.command")
    local event = require("sugar.event")
    local config = require("plugin.jdtls.config")
      or function()
        vim.notify("JDT.LS Configuration Failed", vim.log.levels.WARN, {
          title = "nvim-jdtls",
        })
      end

    command.add("JdtStart", config)
    event.augroup("AttachJDTLS", { event.autocmd("FileType", "java", config) })
  end,
  ft = { "java" },
  module = "jdtls",
}
