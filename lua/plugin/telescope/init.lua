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
    require("plugin.telescope.config")
    require("plugin.telescope.event")
    require("plugin.telescope.keymap")
  end,
  cmd = "Telescope",
  keys = {
    "[]",
    "[p",
    "[f",
    "[ld",
    "[lD",
    "[ls",
    "[lS",
    { "n", "ca" },
    "<Leader>ca",
    "<Leader>e",
    "<Leader>ft",
    "<Leader>gf",
    "<Leader>gb",
    "<Leader>gc",
    "<Leader>gs",
    "<Leader>lo",
    "<Leader>m",
  },
}
