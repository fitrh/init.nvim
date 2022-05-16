local null_ls = require("null-ls")
local c = require("plugin.null-ls.condition")

local js = { "svelte" }
local plaintext = { "gitcommit", "markdown", "txt" }

local formatter = {
  black = { extra_args = { "--line-length", vim.bo.textwidth } },
  brittany = {},
  djlint = { condition = c.djlint },
  fish_indent = {},
  isort = { extra_args = { "--profile", "black" } },
  markdownlint = {},
  phpcbf = {},
  prettierd = { condition = c.prettier, extra_filetypes = js },
  shellharden = {},
  shfmt = { extra_args = { "-i", "4", "-ci" } },
  stylelint = { condition = c.stylelint },
  stylua = { condition = c.stylua },
}

local diagnostic = {
  cppcheck = {
    condition = c.cppcheck,
    extra_args = { "--cppcheck-build-dir=.cppcheck" },
  },
  djlint = { condition = c.djlint },
  eslint_d = { condition = c.eslint, extra_filetypes = js },
  fish = {},
  flake8 = {},
  golangci_lint = { condition = c.golangci },
  markdownlint = {},
  misspell = { filetypes = plaintext },
  mypy = { condition = c.mypy },
  phpcs = {},
  phpstan = { condition = c.phpstan },
  pylint = { condition = c.pylint },
  revive = {
    args = { "-config", "revive.toml", "-formatter", "json", "./..." },
    condition = c.revive,
  },
  selene = { condition = c.selene },
  shellcheck = {},
  staticcheck = { condition = c.staticcheck },
  stylelint = { condition = c.stylelint },
  write_good = { filetypes = plaintext },
}

local code_action = {
  eslint_d = { condition = c.eslint, extra_filetypes = js },
  gitrebase = {},
  shellcheck = {},
}

local registered_sources = {}
for builtin, sources in pairs({
  formatting = formatter,
  diagnostics = diagnostic,
  code_actions = code_action,
}) do
  for source, config in pairs(sources) do
    table.insert(
      registered_sources,
      null_ls.builtins[builtin][source].with(config)
    )
  end
end

null_ls.setup({
  on_attach = function(client, bufnr)
    require("lsp.attach").with.all(client, bufnr)
  end,
  sources = registered_sources,
})
