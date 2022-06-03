local bin = "ls_emmet"

return require("config.lsp.client").with(bin, {
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
