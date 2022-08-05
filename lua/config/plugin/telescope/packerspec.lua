return {
  "nvim-telescope/telescope.nvim",
  requires = {
    { "nvim-lua/plenary.nvim" },
    {
      "nvim-telescope/telescope-file-browser.nvim",
      module = "telescope._extensions.file_browser",
    },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      run = "make",
      module = "telescope._extensions.fzf",
    },
  },
  config = function()
    require("config.plugin.telescope.setup")
    require("config.plugin.telescope.keymap")
  end,
  cmd = "Telescope",
  keys = {
    "gb",
    "gf",
    "gF",
    "[",
    "]",
    "<Leader>k",
    "<Leader>e",
    "<Leader>ft",
    "<Leader>gf",
    "<Leader>lo",
    "<Leader>m",
    "<Leader>h",
    "gS",
    "gC",
    "gB",
  },
  module = "telescope",
}
