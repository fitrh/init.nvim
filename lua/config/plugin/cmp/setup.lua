local max_items = vim.api.nvim_get_option("pumheight")
local cmp = require("cmp")
local snippet = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()

local const = {
  LSP_KIND = require("const.LSP_KIND"),
}

local config = {
  preselect = cmp.PreselectMode.None,
  mapping = require("config.plugin.cmp.keymap").setup(cmp, snippet),
  experimental = { ghost_text = true },
}

config.snippet = {
  expand = function(args)
    snippet.lsp_expand(args.body)
  end,
}

config.window = {
  completion = {
    border = "rounded",
    winhighlight = "FloatBorder:CmpDocumentationBorder,Search:None",
  },
  documentation = {
    border = "rounded",
    winhighlight = "FloatBorder:CmpDocumentationBorder,Search:None",
    max_width = 80,
    max_height = 12,
  },
}

local formatting = {}
formatting.fields = { "kind", "abbr", "menu" }
formatting.format = function(_, vim_item)
  vim_item.menu = vim_item.kind
  vim_item.kind = const.LSP_KIND[vim_item.kind].icon
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
  formatting = {
    fields = { "abbr" },
    format = function(_, vim_item)
      vim_item.kind = nil
      return vim_item
    end,
  },
  sources = cmp.config.sources({
    { name = "cmdline", max_item_count = max_items },
  }, {
    { name = "path", max_item_count = max_items },
  }),
})
