local LUA_LS = os.getenv("LUA_LS")
if not LUA_LS then
  return false
end

local bin = ("%s/bin/lua-language-server"):format(LUA_LS)
local main = ("%s/main.lua"):format(LUA_LS)
local runtime_path = vim.split(package.path, ";")
runtime_path[#runtime_path + 1] = "lua/?.lua"
runtime_path[#runtime_path + 1] = "lua/?/init.lua"

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
      hint = { enable = true, setType = true },
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
