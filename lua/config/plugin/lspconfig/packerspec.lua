local M = {
  "neovim/nvim-lspconfig",
  config = function()
    require("config.plugin.lspconfig.setup")
  end,
  ft = {
    "astro",
    "bib",
    "c",
    "cpp",
    "cs",
    "css",
    "fennel",
    "go",
    "gomod",
    "gotmpl",
    "groovy",
    "haml",
    "handlebars",
    "haskell",
    "hbs",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "jsonc",
    "kotlin",
    "less",
    "lua",
    "markdown",
    "php",
    "pug",
    "python",
    "sass",
    "scss",
    "sh",
    "slim",
    "sss",
    "stylus",
    "svelte",
    "svg",
    "tex",
    "toml",
    "typescript",
    "typescriptreact",
    "vb",
    "vlang",
    "vue",
    "xml",
    "xsd",
    "xsl",
    "xslt",
    "yaml",
    "zig",
    "zir",
  },
  module = "lspconfig",
}

return M
