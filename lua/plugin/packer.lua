vim.cmd("packadd packer.nvim")

local plugins = {
  { "nvim-lua/plenary.nvim", module = "plenary" },
  { "gpanders/editorconfig.nvim", event = { "BufReadPost", "BufNewFile" } },
  { "ray-x/lsp_signature.nvim", module = "lsp_signature" },
  { "yamatsum/nvim-nonicons", module = "nvim-nonicons" },
  { "jose-elias-alvarez/nvim-lsp-ts-utils", module = "nvim-lsp-ts-utils" },
  { "b0o/schemastore.nvim", ft = { "json", "jsonc" } },
  require("plugin.filetype.packerspec"),
  require("plugin.treesitter.packerspec"),
  require("plugin.lspconfig.packerspec"),
  require("plugin.clangdext.packerspec"),
  require("plugin.jdtls.packerspec"),
  require("plugin.rust-tools.packerspec"),
  require("plugin.flutter-tools.packerspec"),
  require("plugin.crates.packerspec"),
  require("plugin.null-ls.packerspec"),
  require("plugin.sandwich.packerspec"),
  require("plugin.kommentary.packerspec"),
  require("plugin.hop.packerspec"),
  require("plugin.cmp.packerspec"),
  -- require("plugin.autopairs.packerspec"), -- FIXME: glitch on <CR>
  require("plugin.pears.packerspec"), -- work best with treesitter
  require("plugin.telescope.packerspec"),
  require("plugin.dressing.packerspec"),
  require("plugin.gitsigns.packerspec"),
  require("plugin.neoscroll.packerspec"),
  require("plugin.colorscheme.packerspec"),
  require("plugin.devicons.packerspec"),
  require("plugin.lualine.packerspec"),
  require("plugin.colorizer.packerspec"),
  require("plugin.modes.packerspec"),
  require("plugin.todo-comments.packerspec"),
  require("plugin.trouble.packerspec"),
  require("plugin.headlines.packerspec"),
  require("plugin.notify.packerspec"),
  require("plugin.fidget.packerspec"),
  require("plugin.window-picker.packerspec"),
  { "baskerville/vim-sxhkdrc", ft = "sxhkdrc" },
}

local packer = require("packer")
local config = require("plugin.packer.config")
packer.init(config.init)
packer.startup(config.use(plugins))

local augroup = require("sugar.augroup")
augroup("OnPackerEvent", {
  "User PackerCompileDone",
  callback = function()
    vim.notify("Compiled", "success", { title = "packer.nvim" })
  end,
})
