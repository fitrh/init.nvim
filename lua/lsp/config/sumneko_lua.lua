local handler = require("lsp.handler")
local attach = require("lsp.attach")
local capabilities = require("lsp.capability")

local src = ("%s/git/lua-language-server"):format(os.getenv("HOME"))
local cmd = ("%s/bin/Linux/lua-language-server"):format(src)
local main = ("%s/main.lua"):format(src)
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

return {
  cmd = { cmd, "-E", main },
  capabilities = capabilities,
  handlers = handler.default(),
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = runtime_path,
      },
      diagnostics = { globals = { "vim" } },
      workspace = {
        library = vim.api.nvim_get_runtime_file("lua", true),
      },
      telemetery = { enable = false },
    },
  },
  on_attach = attach.with_all_extensions,
}
