vim.cmd.packadd("packer.nvim") -- TODO: remove `.nvim` suffix

local function spec(name)
  return require("config.plugin." .. name .. ".packerspec")
end

local plugins = {
  { "nvim-lua/plenary.nvim" },
  { "ray-x/lsp_signature.nvim" },
  { "b0o/schemastore.nvim", ft = { "json", "jsonc" } },
  require("config.plugin.treesitter.packerspec"),
  require("config.plugin.treesitter-context.packerspec"),
  -- spec("ts-context-commentstring"),
  spec("ts-autotag"),
  require("config.plugin.lspconfig.packerspec"),
  require("config.plugin.clangd_extensions.packerspec"),
  require("config.plugin.jdtls.packerspec"),
  spec("metals"),
  require("config.plugin.rust-tools.packerspec"),
  require("config.plugin.flutter-tools.packerspec"),
  spec("pubspec-assist"),
  require("config.plugin.typescript.packerspec"),
  require("config.plugin.crates.packerspec"),
  require("config.plugin.phpactor.packerspec"),
  require("config.plugin.null-ls.packerspec"),
  -- require("config.plugin.litee.packerspec"),
  require("config.plugin.tailwindcss-colors.packerspec"), -- require("config.plugin.document-color.packerspec"),
  spec("dap"),
  require("config.plugin.surround.packerspec"),
  -- require("config.plugin.kommentary.packerspec"),
  require("config.plugin.hop.packerspec"),
  require("config.plugin.cmp.packerspec"),
  require("config.plugin.autopairs.packerspec"),
  require("config.plugin.telescope.packerspec"),
  require("config.plugin.gitsigns.packerspec"),
  require("config.plugin.numb.packerspec"),
  require("config.plugin.dial.packerspec"),
  require("config.plugin.colorscheme.packerspec"),
  require("config.plugin.incline.packerspec"),
  require("config.plugin.navic.packerspec"),
  require("config.plugin.ccc.packerspec"),
  require("config.plugin.modes.packerspec"),
  require("config.plugin.notify.packerspec"),
  require("config.plugin.fidget.packerspec"),
  spec("lightbulb"),
  spec("neotest"),
}

local packer = require("packer")
local setup = require("config.plugin.packer.setup")
packer.init(setup.init)
packer.startup(setup.use(plugins))

-- TODO: remove sugar.augroup usage
require("sugar.augroup")("packer_event_action", function(autocmd)
  autocmd("User", "PackerCompileDone", function()
    vim.notify((" Compiled at %s"):format(os.date()), vim.log.levels.INFO, {
      title = "packer.nvim",
    })
  end)
end)
