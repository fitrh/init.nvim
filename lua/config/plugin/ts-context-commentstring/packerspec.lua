return {
  "JoosepAlviste/nvim-ts-context-commentstring",
  after = "nvim-treesitter",
  config = function()
    require("config.plugin.ts-context-commentstring.setup")
  end,
  setup = function()
    vim.api.nvim_set_var("skip_ts_context_commentstring_module", true)
  end,
}
