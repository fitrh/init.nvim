local null_ls = require("null-ls")

local formatter = {
  "black",
  "brittany",
  "djlint",
  "fish_indent",
  "isort",
  -- "jq",
  "ktlint",
  "markdownlint",
  "phpcbf",
  "pint",
  "prettierd",
  "shfmt",
  "stylelint",
  "stylua",
  "taplo",
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
  "markdownlint", -- TODO use markdownlint_cli2
  -- "misspell",
  "mypy",
  "phpcs",
  "phpstan",
  "pylint",
  "revive",
  "selene",
  -- "shellcheck", -- use bash_ls integration
  "staticcheck",
  "stylelint",
  "tidy",
  "typos",
  -- "write_good",
  -- "vale",
}

local code_action = { "eslint_d", "gitrebase", "shellcheck" }

local registered_sources = {}
local with_config = require("config.plugin.null-ls.with")
for builtin, sources in pairs({
  formatting = formatter,
  diagnostics = diagnostic,
  code_actions = code_action,
}) do
  for _, source in ipairs(sources) do
    local config = with_config[source] or {}
    source = null_ls.builtins[builtin][source].with(config)
    registered_sources[#registered_sources + 1] = source
  end
end

null_ls.setup({
  log_level = "trace",
  on_attach = function(client, bufnr)
    require("config.lsp.attach").with.all(client, bufnr)
  end,
  sources = registered_sources,
})
