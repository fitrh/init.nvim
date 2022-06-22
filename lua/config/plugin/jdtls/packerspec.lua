return {
  "mfussenegger/nvim-jdtls",
  config = function()
    local config = require("config.plugin.jdtls.setup")
      or function()
        vim.notify("JDT.LS Configuration Failed", vim.log.levels.WARN, {
          title = "nvim-jdtls",
        })
      end

    require("sugar.command").add("JdtStart", config)
    require("sugar.augroup")("AttachJDTLS", function(autocmd)
      autocmd("FileType", "java", config)
    end)
  end,
  ft = { "java" },
  module = "jdtls",
}
