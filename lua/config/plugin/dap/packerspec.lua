return {
  "mfussenegger/nvim-dap",
  requires = {
    { "mfussenegger/nvim-dap-python", module = "dap-python" },
  },
  config = function()
    require("config.plugin.dap.setup")
  end,
  cmd = "Debug",
  module = "dap",
}
