local setup = require("lsp.config")
local bin = "rust-analyzer"
local config = {}

config.settings = {
  ["rust-analyzer"] = {
    hoverActions = { references = true },
    rustfmt = { enableRangeFormatting = true },
  },
}

config.on_attach = function(client, bufnr)
  require("lsp.attach").with.all(client, bufnr)
  require("plugin.rust-tools.keymap").attach(bufnr)
end

local server = setup.with(bin, config)
if not server then
  return false
end

require("rust-tools").setup({
  tools = { hover_actions = { auto_focus = true } },
  server = server,
})
