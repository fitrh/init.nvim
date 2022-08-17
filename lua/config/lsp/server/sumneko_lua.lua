local LUA_LS_SRC = os.getenv("LUA_LS")
if not LUA_LS_SRC then
  return false
end

local bin = ("%s/bin/lua-language-server"):format(LUA_LS_SRC)
local main = ("%s/main.lua"):format(LUA_LS_SRC)
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

return require("config.lsp.server").with(bin, {
  cmd = { bin, "-E", main },
  settings = {
    Lua = {
      completion = {
        callSnippet = "Both",
        keywordSnippet = "Both",
      },
      diagnostics = { globals = { "vim" } },
      format = { enable = false },
      hint = {
        enable = true,
        setType = true,
      },
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
