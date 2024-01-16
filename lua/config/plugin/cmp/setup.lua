local cmp = require("cmp")
local snippet = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()

local config = {
  preselect = cmp.PreselectMode.None,
  mapping = require("config.plugin.cmp.keymap").setup(cmp, snippet),
  experimental = { ghost_text = true },
  completion = { keyword_length = 3 },
  matching = {
    disallow_partial_fuzzy_matching = false,
  },
}

config.snippet = {
  expand = function(args)
    snippet.lsp_expand(args.body)
  end,
}

local COMPLETION_KIND = require("const.LSP_KIND").Completion
require("sugar.highlight").colorscheme(function(h)
  local base = h.bg("Pmenu", { "NormalFloat", "Normal" })
  for kind, _ in pairs(COMPLETION_KIND) do
    local inherit = ("CmpItemKind%s"):format(kind)
    local group = ("%sIcon"):format(inherit)
    local fallback = { ("@%s"):format(kind:lower()), "CmpItemKindDefault" }
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

  local source = entry.source.name
  if source == "nvim_lsp" or source == "path" then
    item.menu_hl_group = kind_hl_group
  else
    item.menu_hl_group = "Comment"
  end
  item.menu = kind

  if source == "buffer" then
    item.menu_hl_group = nil
    item.menu = nil
  end

  local half_win_width = math.floor(vim.api.nvim_win_get_width(0) * 0.5)
  if vim.api.nvim_strwidth(item.abbr) > half_win_width then
    item.abbr = ("%s…"):format(item.abbr:sub(1, half_win_width))
  end

  if item.menu then -- Add exta space to visually differentiate `abbr` and `menu`
    item.abbr = ("%s "):format(item.abbr)
  end

  return item
end
config.formatting = formatting

config.sources = {
  { name = "nvim_lsp", group_index = 1 },
  { name = "luasnip", group_index = 1 },
  { name = "path", keyword_length = 1, group_index = 2 },
  { name = "buffer", group_index = 3 },
}

config.window = {
  completion = {
    winhighlight = "Normal:Pmenu,CursorLine:CmpCursorLine,Search:None",
    col_offset = -3,
    side_padding = 0,
    scrollbar = false,
  },
  documentation = {
    border = "solid",
    winhighlight = "Normal:CmpDoc,FloatBorder:CmpDoc,Search:None",
    max_width = 80,
    max_height = 12,
  },
}

cmp.setup(config)

cmp.setup.filetype("lua", {
  sources = {
    { name = "nvim_lsp", group_index = 1 },
    { name = "nvim_lua", group_index = 1 },
    { name = "luasnip", group_index = 2 },
    { name = "path", group_index = 3 },
    { name = "buffer", group_index = 4 },
  },
})

cmp.setup.cmdline({ "/", "?" }, {
  completion = { keyword_length = 1 },
  sources = {
    { name = "nvim_lsp_document_symbol" },
    { name = "buffer" },
  },
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
  sources = { { name = "cmdline" }, { name = "path" } },
  window = {
    completion = {
      side_padding = 1,
    },
  },
})
