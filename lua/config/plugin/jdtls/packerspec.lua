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
    require("sugar.augroup")("attach_jdtls", function(autocmd)
      autocmd("FileType", "java", config)
    end)
    vim.api.nvim_exec_autocmds("FileType", {
      pattern = vim.bo.filetype,
      modeline = false,
    }) -- SEE: https://github.com/neovim/neovim/issues/23368
  end,
  ft = { "java" },
}
