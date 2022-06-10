local cmp = require("cmp")
local snippet = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()

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

local LSP_KIND = require("const.LSP_KIND")
local formatting = {}
formatting.fields = { "kind", "abbr", "menu" }
formatting.format = function(entry, item)
  item.menu_hl_group = ({
    nvim_lua = "TSConstBuiltin",
    luasnip = "TSComment",
    buffer = "TSString",
    path = "Directory",
  })[entry.source.name] or ("CmpItemKind%s"):format(item.kind)
  item.menu = item.kind
  item.kind = LSP_KIND[item.kind].icon

  local half_win_width = math.floor(vim.api.nvim_win_get_width(0) / 2)
  if vim.api.nvim_strwidth(item.abbr) > half_win_width then
    item.abbr = ("%s…"):format(item.abbr:sub(1, half_win_width))
  end

  return item
end
config.formatting = formatting

local max_items = vim.api.nvim_get_option("pumheight")
config.sources = cmp.config.sources({
  { name = "nvim_lsp", max_item_count = max_items },
  { name = "nvim_lua", max_item_count = max_items / 2 },
  { name = "luasnip", max_item_count = max_items / 2 },
  { name = "path", max_item_count = max_items },
}, {
  { name = "buffer", max_item_count = max_items / 2 },
})

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
    format = function(_, item)
      item.kind = nil
      return item
    end,
  },
  sources = cmp.config.sources({
    { name = "cmdline", max_item_count = max_items },
  }, {
    { name = "path", max_item_count = max_items },
  }),
})
