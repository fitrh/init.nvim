local cmp = require("cmp")
local snippet = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()

local config = {
  preselect = cmp.PreselectMode.None,
  mapping = require("config.plugin.cmp.keymap").setup(cmp, snippet),
  -- experimental = { ghost_text = true },
  completion = { keyword_length = 3 },
  matching = {
    disallow_partial_fuzzy_matching = false,
  },
}

config.snippet = {
  expand = function(args)
    snippet.lsp_expand(args.body)
    -- vim.snippet.expand(args.body)
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

local source_label = { nvim_lua = "Neovim API", luasnip = "LuaSnip" }
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
    -- TODO: check if 'kind' is 'Color', then set the hl-group to its color
  else
    item.menu_hl_group = "Comment"
  end
  item.menu = kind
  -- if source_label[source] then
  --   item.menu = item.menu .. " (" .. source_label[source] .. ")"
  -- end

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

  -- if entry.source.source.client then
  --   item.menu = item.menu .. " " .. entry.source.source.client.name
  -- end

  return item
end
config.formatting = formatting

local lsp = {
  name = "nvim_lsp",
  group_index = 1,
  -- SEE: `:h cmp-config.sources[n].entry_filter`
  -- Remove `Text` kind from completion list
  -- Usually appears inside comment context
  -- When inside comment, it is better to use `buffer` source
  entry_filter = function(entry, _)
    return entry:get_kind() ~= 1
  end,
}

config.sources = {
  lsp, -- { name = "nvim_lsp", group_index = 1 },
  { name = "luasnip", group_index = 1, option = { show_autosnippets = true } },
  { name = "path", keyword_length = 1, group_index = 2 },
  { name = "buffer", group_index = 3 },
}

config.window = {
  completion = {
    winhighlight = "Normal:Pmenu,CursorLine:CmpCursorLine,Search:None",
    scrolloff = function()
      return math.ceil(vim.api.nvim_get_option_value("pumheight", {}) * 0.3)
    end,
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

-- cmp.setup.filetype("lua", {
--   sources = {
--     lsp, -- { name = "nvim_lsp", group_index = 1 },
--     -- { name = "nvim_lua", group_index = 1 },
--     { name = "luasnip", group_index = 2 },
--     { name = "path", group_index = 3 },
--     { name = "buffer", group_index = 4 },
--   },
-- })

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
  sources = {
    {
      name = "cmdline",
      -- option = { treat_trailing_slash = false },
    },
    { name = "path" },
  },
  window = {
    completion = {
      side_padding = 1,
    },
  },
})

-- cmp.event:on("confirm_done", function(e)
--   if e.commit_character then
--     return
--   end
--   local data = {
--     entry = e.entry,
--   }
--   vim.api.nvim_exec_autocmds("User", {
--     pattern = "CmpConfirmDone",
--     data = data,
--   })
-- end)
