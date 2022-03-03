local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local action = null_ls.builtins.code_actions
local condition = require("plugin.null-ls.condition")

null_ls.setup({
  on_attach = require("lsp.attach").with.all,
  sources = {
    formatting.black,
    formatting.brittany,
    formatting.fish_indent,
    formatting.isort.with({ extra_args = { "--profile", "black" } }),
    formatting.markdownlint,
    formatting.prettierd.with({ condition = condition.prettier }),
    formatting.shellharden,
    formatting.shfmt.with({ extra_args = { "-i", "4", "-ci" } }),
    formatting.stylua.with({ condition = condition.stylua }),

    diagnostics.cppcheck.with({
      condition = condition.cppcheck,
      extra_args = { "--cppcheck-build-dir=.cppcheck" },
    }),
    diagnostics.eslint_d.with({ condition = condition.eslint }),
    diagnostics.flake8.with({ diagnostics_format = "[#{c}] #{m}" }),
    diagnostics.golangci_lint,
    diagnostics.markdownlint,
    diagnostics.misspell.with({
      filetypes = { "gitcommit", "markdown", "txt" },
    }),
    diagnostics.mypy.with({
      condition = condition.mypy,
      diagnostics_format = "[#{c}] #{m}",
    }),
    diagnostics.phpcs,
    diagnostics.pylint.with({
      diagnostics_format = "[#{c}] #{m}",
      condition = condition.pylint,
    }),
    diagnostics.selene.with({ condition = condition.selene }),
    diagnostics.shellcheck.with({ diagnostics_format = "[#{c}] #{m}" }),
    diagnostics.write_good.with({ filetypes = { "markdown", "gitcommit" } }),

    action.gitrebase,
    action.shellcheck,
  },
})
