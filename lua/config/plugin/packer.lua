vim.cmd.packadd("packer.nvim")

local plugins = {
  { "nvim-lua/plenary.nvim", module = "plenary" },
  { "ray-x/lsp_signature.nvim", module = "lsp_signature" },
  { "b0o/schemastore.nvim", ft = { "json", "jsonc" } },
  require("config.plugin.treesitter.packerspec"),
  require("config.plugin.treesitter-context.packerspec"),
  require("config.plugin.lspconfig.packerspec"),
  require("config.plugin.clangd_extensions.packerspec"),
  require("config.plugin.jdtls.packerspec"),
  require("config.plugin.rust-tools.packerspec"),
  require("config.plugin.flutter-tools.packerspec"),
  require("config.plugin.typescript.packerspec"),
  require("config.plugin.crates.packerspec"),
  require("config.plugin.phpactor.packerspec"),
  require("config.plugin.null-ls.packerspec"),
  require("config.plugin.litee.packerspec"),
  require("config.plugin.document-color.packerspec"),
  require("config.plugin.surround.packerspec"),
  require("config.plugin.kommentary.packerspec"),
  require("config.plugin.hop.packerspec"),
  require("config.plugin.cmp.packerspec"),
  require("config.plugin.autopairs.packerspec"),
  require("config.plugin.telescope.packerspec"),
  require("config.plugin.gitsigns.packerspec"),
  require("config.plugin.numb.packerspec"),
  require("config.plugin.dial.packerspec"),
  require("config.plugin.colorscheme.packerspec"),
  require("config.plugin.devicons.packerspec"),
  require("config.plugin.incline.packerspec"),
  require("config.plugin.navic.packerspec"),
  require("config.plugin.colorizer.packerspec"),
  require("config.plugin.modes.packerspec"),
  require("config.plugin.notify.packerspec"),
  require("config.plugin.fidget.packerspec"),
}

local packer = require("packer")
local setup = require("config.plugin.packer.setup")
packer.init(setup.init)
packer.startup(setup.use(plugins))

require("sugar.augroup")("packer_event_action", function(autocmd)
  autocmd("User", "PackerCompileDone", function()
    vim.notify((" Compiled at %s"):format(os.date()), vim.log.levels.INFO, {
      title = "packer.nvim",
    })
  end)
end)
