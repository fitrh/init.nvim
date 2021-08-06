vim.cmd [[packadd packer.nvim]]

local packer = require("packer")

packer.init({
  git = {
    clone_timeout = 180, -- Timeout, in seconds
  },
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'rounded' })
    end,
  },
  profile = {
    enable = true,
    -- integer in milliseconds, plugins which load faster than this
    -- won't be shown in profile output
    threshold = 1,
  },
})

local plugins = {
  { "wbthomason/packer.nvim", opt = true },
  { "nvim-lua/popup.nvim", module = "popup" },
  { "nvim-lua/plenary.nvim", module = "plenary" },
  { "nvim-lua/lsp-status.nvim", module = "lsp-status" },
  { "ray-x/lsp_signature.nvim", module = "lsp_signature" },
  { "L3MON4D3/LuaSnip", module = "luasnip" },
  { "kyazdani42/nvim-web-devicons", module = "nvim-web-devicons" },
  { "yamatsum/nvim-nonicons", module = "nvim-nonicons" },
  require("plugin.treesitter"),
  require("plugin.lspconfig"),
  require("plugin.jdtls"),
  require("plugin.sandwich"),
  require("plugin.kommentary"),
  require("plugin.hop"),
  require("plugin.compe"),
  -- require("plugin.autopairs"), -- FIXME: glitch on <CR>
  require("plugin.pears"), -- work best with treesitter
  require("plugin.telescope"),
  require("plugin.gitsigns"),
  require("plugin.outline"),
  require("plugin.neoscroll"),
  require("plugin.tokyonight"),
  require("plugin.lualine"),
  require("plugin.colorizer"),
  -- TODO: add TrueZen (https://github.com/Pocco81/TrueZen.nvim)
  { "baskerville/vim-sxhkdrc", ft = "sxhkdrc" },
}

packer.startup(function(use)
  for _, plugin in ipairs(plugins) do
    use(plugin)
  end
end)
