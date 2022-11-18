local bin = "ls_emmet"

return require("config.lsp.server").with(bin, {
  cmd = { bin, "--stdio" },
  filetypes = {
    "css",
    "haml",
    "handlebars",
    "hbs",
    "html",
    "javascriptreact",
    "less",
    "pug",
    "sass",
    "scss",
    "slim",
    "sss",
    "stylus",
    "svelte",
    "typescriptreact",
    "xml",
    "xsl",
  },
})
