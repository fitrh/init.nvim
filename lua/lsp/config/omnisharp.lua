if not os.getenv("DOTNET_ROOT") then
  return false
end

local setup = require("lsp.config")
local bin = ("%s/omnisharp/run"):format(os.getenv("DOTNET_ROOT"))

return setup.with(bin, {
  cmd = { bin, "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
})
