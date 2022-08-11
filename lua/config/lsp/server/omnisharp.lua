if not os.getenv("DOTNET_ROOT") then
  return false
end

local bin = ("%s/omnisharp/OmniSharp"):format(os.getenv("DOTNET_ROOT"))

return require("config.lsp.server").with(bin, {
  cmd = {
    bin,
    "--languageserver",
    "--hostPID",
    tostring(vim.loop.os_getpid()),
  },
})
