require("rust-tools").setup({
  tools = {
    hover_actions = { auto_focus = true },
  },
  server = {
    capability = require("lsp.capability"),
    handlers = require("lsp.handler").default(),
    settings = {
      ["rust-analyzer"] = {
        hoverActions = { references = true },
        rustfmt = { enableRangeFormatting = true },
      },
    },
    on_attach = function(client, bufnr)
      require("lsp.attach").with.all(client, bufnr)
      require("plugin.rust-tools.keymap").attach()
    end,
  },
})
