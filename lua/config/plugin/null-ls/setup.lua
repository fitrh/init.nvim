local null_ls = require("null-ls")

local formatter = {
  "black",
  "brittany",
  "djlint",
  "fish_indent",
  "isort",
  "ktlint",
  "markdownlint",
  "phpcbf",
  "pint",
  "prettierd",
  "shellharden",
  "shfmt",
  "stylelint",
  "stylua",
  "yamlfmt",
}

local diagnostic = {
  "cppcheck",
  "djlint",
  "eslint_d",
  "fish",
  "flake8",
  "golangci_lint",
  "ktlint",
  "markdownlint",
  "misspell",
  "mypy",
  "phpcs",
  "phpstan",
  "pylint",
  "revive",
  "selene",
  "shellcheck",
  "staticcheck",
  "stylelint",
  "write_good",
}

local code_action = { "eslint_d", "gitrebase", "shellcheck" }

local registered_sources = {}
for builtin, sources in pairs({
  formatting = formatter,
  diagnostics = diagnostic,
  code_actions = code_action,
}) do
  for _, source in ipairs(sources) do
    local config = require("config.plugin.null-ls.with")[source] or {}
    source = null_ls.builtins[builtin][source].with(config)
    table.insert(registered_sources, source)
  end
end

null_ls.setup({
  on_attach = function(client, bufnr)
    require("config.lsp.attach").with.all(client, bufnr)
  end,
  sources = registered_sources,
})
