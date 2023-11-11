return {
  "rcarriga/nvim-notify",
  config = function()
    require("config.plugin.notify.setup")
  end,
  setup = function()
    vim.notify = function(...)
      return require("notify")(...)
    end
  end,
  module = "notify",
}
