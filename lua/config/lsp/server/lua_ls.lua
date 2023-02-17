local runtime_path = vim.split(package.path, ";")
runtime_path[#runtime_path + 1] = "lua/?.lua"
runtime_path[#runtime_path + 1] = "lua/?/init.lua"

return require("config.lsp.server").with("lua-language-server", {
  cmd = { "lua-language-server" },
  settings = {
    Lua = {
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
