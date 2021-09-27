require("rust-tools").setup({
  tools = {
    inlay_hints = {
      parameter_hints_prefix = " ",
      other_hints_prefix = " ",
    },
    hover_actions = { auto_focus = true },
  },
  server = {
    capability = require("lsp.capability"),
    handlers = require("lsp.handler").default(),
    settings = {
      ["rust-analyzer"] = {
        cargo = { allFeatures = true },
        checkOnSave = { command = "clippy" },
        hoverActions = { references = true },
        rustfmt = { enableRangeFormatting = true },
        updates = {
          askBeforeDownload = true,
          channel = "nightly",
        },
        workspace = {
          symbol = {
            search = {
              kind = "all_symbols",
              scope = "workspace_and_dependencies",
            },
          },
        },
      },
    },
    on_attach = function(client, bufnr)
      require("lsp.attach").with_all_extensions(client, bufnr)
      -- TODO: Attach keymap
    end,
  },
})
