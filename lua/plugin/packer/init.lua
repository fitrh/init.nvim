vim.cmd("packadd packer.nvim")

local packer = require("packer")

packer.init({
  git = {
    clone_timeout = 180, -- Timeout, in seconds
  },
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
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
  { "nvim-lua/plenary.nvim", module = "plenary" },
  { "nvim-lua/lsp-status.nvim", module = "lsp-status" },
  { "ray-x/lsp_signature.nvim", module = "lsp_signature" },
  { "L3MON4D3/LuaSnip", module = "luasnip" },
  { "kyazdani42/nvim-web-devicons", module = "nvim-web-devicons" },
  { "yamatsum/nvim-nonicons", module = "nvim-nonicons" },
  { "jose-elias-alvarez/nvim-lsp-ts-utils", module = "nvim-lsp-ts-utils" },
  { "nathom/filetype.nvim", event = { "BufNewFile", "BufRead" } },
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
  require("plugin.lualine"),
  require("plugin.colorizer"),
  require("plugin.modes"),
  require("plugin.todo-comments"),
  require("plugin.headlines"),
  { "baskerville/vim-sxhkdrc", ft = "sxhkdrc" },
}

packer.startup(function(use)
  for _, plugin in ipairs(plugins) do
    use(plugin)
  end
end)
