return {
  "mfussenegger/nvim-jdtls",
  config = function()
    require("lib.command").create({
      name = "JdtStart",
      cmd = 'lua require("plugin.jdtls.config")()',
    })
    require("lib.event.augroup").setup({
      ["AttachJDTLS"] = {
        {
          events = "FileType",
          filter = "java",
          cmd = "JdtStart",
        },
      },
    })
  end,
  ft = { "java" },
  module = "jdtls",
}
