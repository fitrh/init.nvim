return {
  {
    "ldelossa/litee.nvim",
    config = function()
      require("config.plugin.litee.setup")
    end,
    event = "LspAttach",
  },
  {
    "ldelossa/litee-symboltree.nvim",
    module = "litee.symboltree",
  },
  {
    "ldelossa/litee-calltree.nvim",
    module = "litee.calltree",
  },
}
