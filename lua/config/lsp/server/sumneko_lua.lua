if not os.getenv("LUALS") then
  return false
end

local src = os.getenv("LUALS")
local bin = ("%s/bin/lua-language-server"):format(src)
local main = ("%s/main.lua"):format(src)
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

return require("config.lsp.server").with(bin, {
  cmd = { bin, "-E", main },
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      format = { enable = false },
      runtime = {
        path = runtime_path,
        version = "LuaJIT",
      },
      telemetery = { enable = false },
      workspace = {
        library = vim.api.nvim_get_runtime_file("lua", true),
        preloadFileSize = 1000,
      },
    },
  },
})
