return {
  "mfussenegger/nvim-jdtls",
  config = function()
    require("lib.event.augroup").setup({
      ["AttachJDTLS"] = {
        {
          events = "FileType",
          filter = "java",
          cmd = [[lua require("plugin.jdtls.config").attach()]],
        },
      },
    })
  end,
  ft = { "java" },
}
