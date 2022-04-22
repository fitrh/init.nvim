local setup = require("lsp.config")
local bin = "ls_emmet"

return setup.with(bin, {
  cmd = { bin, "--stdio" },
  filetypes = {
    "css",
    "haml",
    "handlebars",
    "hbs",
    "html",
    "javascript",
    "javascriptreact",
    "less",
    "pug",
    "sass",
    "scss",
    "slim",
    "sss",
    "stylus",
    "svelte",
    "typescript",
    "typescriptreact",
    "xml",
    "xsl",
  },
})
