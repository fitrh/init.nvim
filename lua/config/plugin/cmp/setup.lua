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

config.completion = { keyword_length = 3 }

local COMPLETION_KIND = require("const.LSP_KIND").Completion

local source_hl = {
  nvim_lua = "TSConstBuiltin",
  luasnip = "TSComment",
  buffer = "TSString",
  path = "Directory",
}

require("sugar.highlight").colorscheme(function(h)
  local base = h.bg("Normal")
  for kind, _ in pairs(COMPLETION_KIND) do
    local inherit = ("CmpItemKind%s"):format(kind)
    local group = ("%sIcon"):format(inherit)
    local fallback = { ("TS%s"):format(kind), "CmpItemKindDefault" }
    local bg = h.blend(h.fg(inherit, fallback), base, 0.15)
    h.set(group, { inherit = inherit, bg = bg })
  end
end)

local formatting = {}
formatting.fields = { "kind", "abbr", "menu" }
formatting.format = function(entry, item)
  local kind = item.kind
  local kind_hl_group = ("CmpItemKind%s"):format(kind)

  item.kind_hl_group = ("%sIcon"):format(kind_hl_group)
  item.kind = (" %s "):format(COMPLETION_KIND[kind].icon)

  item.menu_hl_group = source_hl[entry.source.name] or kind_hl_group
  item.menu = kind

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
    winhighlight = "Normal:Pmenu,FloatBorder:CmpDocumentationBorder,Search:None",
    side_padding = 0,
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
  completion = { keyword_length = 1 },
  sources = cmp.config.sources({
    { name = "nvim_lsp_document_symbol", max_item_count = max_items },
  }, {
    { name = "buffer", max_item_count = max_items },
  }),
})

cmp.setup.cmdline(":", {
  completion = { keyword_length = 1 },
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
  window = {
    completion = {
      side_padding = 1,
    },
  },
})
