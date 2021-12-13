vim.cmd("packadd packer.nvim")

local plugins = {
  { "nvim-lua/plenary.nvim", module = "plenary" },
  { "nvim-lua/lsp-status.nvim", module = "lsp-status" },
  { "ray-x/lsp_signature.nvim", module = "lsp_signature" },
  { "L3MON4D3/LuaSnip", module = "luasnip" },
  { "rafamadriz/friendly-snippets", event = "InsertEnter" },
  { "yamatsum/nvim-nonicons", module = "nvim-nonicons" },
  { "jose-elias-alvarez/nvim-lsp-ts-utils", module = "nvim-lsp-ts-utils" },
  require("plugin.filetype"),
  require("plugin.treesitter"),
  require("plugin.lspconfig"),
  require("plugin.jdtls"),
  require("plugin.rust-tools"),
  require("plugin.crates"),
  require("plugin.null-ls"),
  require("plugin.sandwich"),
  require("plugin.kommentary"),
  require("plugin.hop"),
  require("plugin.cmp"),
  -- require("plugin.autopairs"), -- FIXME: glitch on <CR>
  require("plugin.pears"), -- work best with treesitter
  require("plugin.telescope"),
  require("plugin.gitsigns"),
  require("plugin.outline"),
  require("plugin.neoscroll"),
  require("plugin.tokyonight"),
  require("plugin.devicons"),
  require("plugin.lualine"),
  require("plugin.colorizer"),
  require("plugin.modes"),
  require("plugin.todo-comments"),
  require("plugin.headlines"),
  { "baskerville/vim-sxhkdrc", ft = "sxhkdrc" },
}

local packer = require("packer")
local config = require("plugin.packer.config")
packer.init(config.init)
packer.startup(config.use(plugins))
