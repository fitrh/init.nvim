local max_items = vim.api.nvim_get_option("pumheight")
local cmp = require("cmp")
local snippet = require("luasnip")

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  snippet = {
    expand = function(args)
      snippet.lsp_expand(args.body)
    end,
  },
  preselect = cmp.PreselectMode.None,
  documentation = {
    border = require("helper.border").rounded,
    maxwidth = 80,
    maxheight = 12,
  },
  mapping = require("plugin.cmp.keymap").setup(cmp, snippet),
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = require("lsp.ui.completion").kind()[vim_item.kind]

      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        nvim_lua = "[Neovim Lua]",
        luasnip = "[LuaSnip]",
        buffer = "[Buffer]",
        path = "[Path]",
      })[entry.source.name]

      return vim_item
    end,
  },
  experimental = { ghost_text = true },
  sources = cmp.config.sources({
    { name = "nvim_lsp", max_item_count = max_items },
    { name = "nvim_lua", max_item_count = max_items / 2 },
    { name = "luasnip", max_item_count = max_items / 2 },
    { name = "path", max_item_count = max_items },
  }, {
    { name = "buffer", max_item_count = max_items / 2 },
  }),
})

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
