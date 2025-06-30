return require("config.lsp.server").with("lua-language-server", {
  cmd = { "lua-language-server" },
  settings = {
    Lua = {
      format = { enable = false },
      hint = { enable = true, setType = true },
      telemetery = { enable = false },
    },
  },
})
