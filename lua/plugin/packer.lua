vim.cmd("packadd packer.nvim")

local plugins = {
  { "nvim-lua/plenary.nvim", module = "plenary" },
  { "gpanders/editorconfig.nvim", event = { "BufReadPost", "BufNewFile" } },
  { "ray-x/lsp_signature.nvim", module = "lsp_signature" },
  { "b0o/schemastore.nvim", ft = { "json", "jsonc" } },
  { "themaxmarchuk/tailwindcss-colors.nvim", module = "tailwindcss-colors" },
  require("plugin.filetype.packerspec"),
  require("plugin.treesitter.packerspec"),
  require("plugin.treesitter-context.packerspec"),
  require("plugin.lspconfig.packerspec"),
  require("plugin.clangdext.packerspec"),
  require("plugin.jdtls.packerspec"),
  require("plugin.rust-tools.packerspec"),
  require("plugin.flutter-tools.packerspec"),
  require("plugin.typescript.packerspec"),
  require("plugin.crates.packerspec"),
  require("plugin.null-ls.packerspec"),
  require("plugin.litee.packerspec"),
  require("plugin.sandwich.packerspec"),
  require("plugin.kommentary.packerspec"),
  require("plugin.hop.packerspec"),
  require("plugin.cmp.packerspec"),
  require("plugin.autopairs.packerspec"),
  require("plugin.telescope.packerspec"),
  require("plugin.dressing.packerspec"),
  require("plugin.gitsigns.packerspec"),
  require("plugin.cinnamon.packerspec"),
  require("plugin.numb.packerspec"),
  require("plugin.dial.packerspec"),
  require("plugin.colorscheme.packerspec"),
  require("plugin.devicons.packerspec"),
  require("plugin.lualine.packerspec"),
  require("plugin.incline.packerspec"),
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
    vim.notify(
      (" Compiled at %s"):format(os.date()),
      vim.log.levels.INFO,
      { title = "packer.nvim" }
    )
  end,
})
