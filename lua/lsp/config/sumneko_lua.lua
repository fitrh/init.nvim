if not os.getenv("LUALS") then
  return false
end

local setup = require("lsp.config")
local src = os.getenv("LUALS")
local bin = ("%s/bin/lua-language-server"):format(src)
local main = ("%s/main.lua"):format(src)
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

return setup.with(bin, {
  cmd = { bin, "-E", main },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = runtime_path,
      },
      diagnostics = { globals = { "vim" } },
      workspace = {
        library = vim.api.nvim_get_runtime_file("lua", true),
        preloadFileSize = 1000,
      },
      telemetery = { enable = false },
    },
  },
})
