local max_items = vim.api.nvim_get_option("pumheight")
local cmp = require("cmp")
local snippet = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()

local const = {
  BORDER_CHAR = require("const.BORDER_CHAR"),
  LSP_KIND = require("const.LSP_KIND"),
}

local config = {
  preselect = cmp.PreselectMode.None,
  mapping = require("plugin.cmp.keymap").setup(cmp, snippet),
  experimental = { ghost_text = true },
}

config.snippet = {
  expand = function(args)
    snippet.lsp_expand(args.body)
  end,
}

config.documentation = {
  border = const.BORDER_CHAR.ROUNDED,
  maxwidth = 80,
  maxheight = 12,
}

local formatting = {}
formatting.fields = { "kind", "abbr", "menu" }
formatting.format = function(entry, vim_item)
  vim_item.kind = const.LSP_KIND[vim_item.kind].icon

  local menu = ({
    nvim_lsp = "LSP",
    nvim_lua = "API",
    luasnip = "Snippet",
    buffer = "Buffer",
    path = "Path",
  })[entry.source.name]
  vim_item.menu = menu and ("━━ %s"):format(menu) or menu

  return vim_item
end
config.formatting = formatting

config.sources = cmp.config.sources({
  { name = "nvim_lsp", max_item_count = max_items },
  { name = "nvim_lua", max_item_count = max_items / 2 },
  { name = "luasnip", max_item_count = max_items / 2 },
  { name = "path", max_item_count = max_items },
}, {
  { name = "buffer", max_item_count = max_items / 2 },
})

cmp.setup(config)

cmp.setup.cmdline("/", {
  sources = cmp.config.sources({
    { name = "nvim_lsp_document_symbol", max_item_count = max_items },
  }, {
    { name = "buffer", max_item_count = max_items },
  }),
})

cmp.setup.cmdline(":", {
  sources = cmp.config.sources({
    { name = "cmdline", max_item_count = max_items },
  }, {
    { name = "path", max_item_count = max_items },
  }),
})
