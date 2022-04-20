return {
  "nacro90/numb.nvim",
  config = function()
    require("numb").setup()
  end,
  event = "CmdlineEnter",
}
