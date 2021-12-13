local cmp = require("cmp")
local snippet = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load({
  paths = {
    -- TODO: do not use absolute path
    "/home/fitrh/.local/share/nvim/site/pack/packer/opt/friendly-snippets",
  },
})

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
      vim_item.kind = require("lsp.ui.completion").kind({
        text = true,
        icon = "default",
      })[vim_item.kind]

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
    { name = "nvim_lsp", max_item_count = 10 },
    { name = "nvim_lua", max_item_count = 5 },
    { name = "luasnip", max_item_count = 5 },
    { name = "path", max_item_count = 10 },
  }, {
    { name = "buffer", max_item_count = 5 },
  }),
})

cmp.setup.cmdline("/", {
  sources = cmp.config.sources({
    { name = "nvim_lsp_document_symbol", max_item_count = 10 },
  }, {
    { name = "buffer", max_item_count = 10 },
  }),
})

cmp.setup.cmdline(":", {
  sources = cmp.config.sources({
    { name = "cmdline", max_item_count = 10 },
  }, {
    { name = "path", max_item_count = 10 },
  }),
})
